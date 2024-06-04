import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/database/pass_database.dart';
import 'package:warnersos/models/pass.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:warnersos/widgets/screen_button.dart';
import 'package:warnersos/widgets/screen_textfield.dart';

class AddPass extends StatefulWidget {
  const AddPass({super.key});

  @override
  State<AddPass> createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  // Preferences
  late bool useDarkTheme = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      useDarkTheme = prefs.getBool('useDarkTheme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Add Pass',
      children: [
        ScreenTextfield(
          controller: titleController,
          hintText: 'Title',
        ),
        ScreenTextfield(
          controller: dataController,
          hintText: 'Data',
        ),
        const SizedBox(height: 40),
        ScreenButton(
          text: 'Save Pass',
          onPressed: addPass,
        ),
      ],
    );
  }

  Future<void> addPass() async {
    final title = titleController.text;
    final data = dataController.text;

    await PassDatabaseHelper.instance.add(
      Pass(data: data, title: title, format: 0)
    );

    Navigator.of(context).pop();
  }

}