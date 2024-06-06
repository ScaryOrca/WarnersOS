import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/screens/tools.dart';

class Lockscreen extends StatefulWidget {
  const Lockscreen({super.key});

  @override
  State<Lockscreen> createState() => _LockscreenState();
}

class _LockscreenState extends State<Lockscreen> {
  late bool useDarkTheme = false;

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      useDarkTheme = prefs.getBool('useDarkTheme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              '9:23 PM',
              style: TextStyle(
                color: Colors.black,
                fontSize: 65,
                fontWeight: FontWeight.w300,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: navigateToTools,
              icon: Icon(Icons.home_outlined),
              iconSize: 60,
              color: useDarkTheme ? Colors.white : Colors.black,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      backgroundColor: useDarkTheme ? Colors.black : Colors.white,
    );
  }

  void navigateToTools() {
    final route = MaterialPageRoute(
      builder: (context) => Tools(),
    );
    Navigator.push(context, route);
  }
}