import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenCard extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;

  const ScreenCard({super.key, required this.title, this.onTap});

  @override
  State<ScreenCard> createState() => _ScreenCardState();
}

class _ScreenCardState extends State<ScreenCard> {
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
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      color: useDarkTheme ? Colors.black : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          onTap: widget.onTap,
          title: Text(
            widget.title,
            style: TextStyle(
              color: useDarkTheme ? Colors.white : Colors.black,
              fontSize: 30,
            ),
          ),
        ) 
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: useDarkTheme ? Colors.white : Colors.black,
          width: 3,
        ),
      ),
    );
  }
}