import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onSubmitted;

  const ScreenTextfield({super.key, this.controller, required this.hintText, this.onSubmitted});

  @override
  State<ScreenTextfield> createState() => _ScreenTextfieldState();
}

class _ScreenTextfieldState extends State<ScreenTextfield> {
  // Global Preferences
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
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: useDarkTheme ? Colors.white : Colors.black,
          fontSize: 30
        ),
        contentPadding: EdgeInsets.only(top: 20, bottom: 20),
        enabledBorder: UnderlineInputBorder(      
        borderSide:
          BorderSide(color: useDarkTheme ? Colors.white : Colors.black, width: 3),   
        ),  
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: useDarkTheme ? Colors.white : Colors.black, width: 3),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: useDarkTheme ? Colors.white : Colors.black, width: 3),
        ),
      ),
      onSubmitted: widget.onSubmitted,
      style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black, decorationColor: useDarkTheme ? Colors.white : Colors.black,),
      cursorColor: useDarkTheme ? Colors.white : Colors.black,
    );
  }
}