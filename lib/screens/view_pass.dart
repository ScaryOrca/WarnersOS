import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/models/pass.dart';
import 'package:warnersos/screens/edit_pass.dart';
import 'package:warnersos/widgets/screen.dart';

class ViewPass extends StatefulWidget {
  final Pass pass;

  const ViewPass({super.key, required this.pass});

  @override
  State<ViewPass> createState() => _ViewPassState();
}

class _ViewPassState extends State<ViewPass> {
  // Preferences
  late bool useDarkTheme = false;

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
      title: widget.pass.title,
      editScreen: navigateToEditPass,
      children: [
        QrImageView(
          data: widget.pass.data,
          backgroundColor: Colors.white,
          dataModuleStyle: QrDataModuleStyle(
            color: Colors.black,
            dataModuleShape: QrDataModuleShape.square
          ),
        ),
      ],
    );
  }

void navigateToEditPass() {
  final route = MaterialPageRoute(
    builder: (context) => EditPass(pass: widget.pass),
  );
  Navigator.push(context, route);
}
}