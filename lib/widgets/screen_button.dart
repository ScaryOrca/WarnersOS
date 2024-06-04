import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenButton extends StatefulWidget {
  // Widget Parameters
  final String text;
  final VoidCallback? onPressed;

  const ScreenButton({super.key, required this.text, required this.onPressed});

  @override
  State<ScreenButton> createState() => _ScreenButtonState();
}

class _ScreenButtonState extends State<ScreenButton> {
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
    return UnconstrainedBox(
      child: 
        OutlinedButton (
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: useDarkTheme ? Colors.white : Colors.black,
            width: 3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.all(20),
        ),
        child: Text(
          widget.text,
          style: TextStyle(color: useDarkTheme ? Colors.white : Colors.black, fontSize: 30),
        ),
      ),
    );
    
    
  }
}