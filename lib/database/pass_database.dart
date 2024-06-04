import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:warnersos/models/pass.dart';

class PassDatabaseHelper {
  PassDatabaseHelper._privateConstructor();
  static final PassDatabaseHelper instance = PassDatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'passes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE passes(
          id INTEGER PRIMARY KEY,
          title TEXT,
          data TEXT,
          format INTEGER
      )
      ''');
  }

  Future<List<Pass>> getPasses() async {
    Database db = await instance.database;
    var passes = await db.query('passes', orderBy: 'title');
    List<Pass> passList = passes.isNotEmpty
        ? passes.map((c) => Pass.fromMap(c)).toList()
        : [];

    return passList;
  }

  Future<int> add(Pass pass) async {
    Database db = await instance.database;

    return await db.insert('passes', pass.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;

    return await db.delete('passes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Pass pass) async {
    Database db = await instance.database;

    return await db.update('passes', pass.toMap(),
        where: "id = ?", whereArgs: [pass.id]);
  }
}