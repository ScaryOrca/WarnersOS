import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/widgets/screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const platform = MethodChannel('com.warnersnotes.warnersos/navigationBar');
  late bool enableNavigationBar = false;
  late bool useDarkTheme = false;

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      enableNavigationBar = prefs.getBool('enableNavigationBar') ?? false;
      useDarkTheme = prefs.getBool('useDarkTheme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Screen(
      title: 'Settings',
      forceDarkTheme: useDarkTheme,
      children: [
        CheckboxListTile(
          title: Text('Use Dark Theme', style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black)),
          checkColor: useDarkTheme ? Colors.white : Colors.black,
          activeColor: useDarkTheme ? Colors.black : Colors.white,
          value: useDarkTheme,
          onChanged: (bool? value) async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            setState(() {
              useDarkTheme = value ?? false;
              prefs.setBool('useDarkTheme', useDarkTheme);
            });
          },
        ),
        CheckboxListTile(
          title: Text('Enable Navigation Bar', style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black)),
          checkColor: useDarkTheme ? Colors.white : Colors.black,
          activeColor: useDarkTheme ? Colors.black : Colors.white,
          value: enableNavigationBar,
          onChanged: (bool? value) async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            setState(() {
              enableNavigationBar = value ?? false;
              prefs.setBool('enableNavigationBar', enableNavigationBar);
            });

            toggleNavigationBar();
          },
        ),
      ],
    );
  }

  void toggleNavigationBar() async {
    try {
      if (enableNavigationBar) {
        await platform.invokeMethod<int>('enableNavBar');
      } else {
        await platform.invokeMethod<int>('disableNavBar');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}