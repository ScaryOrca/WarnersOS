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
  String passTitle = '';
  String passData = '';

  // Preferences
  late bool useDarkTheme = false;

  @override
  void initState() {
    loadPreferences();

    setState(() {
      passTitle = widget.pass.title;
      passData = widget.pass.data;
    });

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
      title: passTitle,
      editScreen: navigateToEditPass,
      children: [
        QrImageView(
          data: passData,
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
    final modifiedPass = Pass(title: passTitle, data: passData, id: widget.pass.id, format: 0);
    final route = MaterialPageRoute(
      builder: (context) => EditPass(pass: modifiedPass),
    );

    Navigator.push(context, route).then((value) {
      if (value != null) {
        setState(() {
          passTitle = (value as Pass).title;
          passData = (value as Pass).data;
        });
      }
      
    });
  }
}