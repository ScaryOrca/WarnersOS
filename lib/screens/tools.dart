import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/screens/chatgpt.dart';
import 'package:warnersos/screens/mfa.dart';
import 'package:warnersos/screens/passes.dart';
import 'package:warnersos/screens/phone.dart';
import 'package:warnersos/screens/settings.dart';
import 'package:warnersos/screens/weather.dart';

class Tools extends StatefulWidget {
  const Tools({super.key});

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  late bool useDarkTheme = false;
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    loadPreferences();
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      useDarkTheme = prefs.getBool('useDarkTheme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Right swipe
        if (details.delta.dx > 0 && currentPage > 0) {
          _pageController.jumpToPage(currentPage - 1);

          setState(() {
            currentPage = currentPage - 1;
          });
        }
        // Left swipe
        else if (details.delta.dx < 0 && currentPage < 1) {
          _pageController.jumpToPage(currentPage + 1);
          
          setState(() {
            currentPage = currentPage + 1;
          });
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child:
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 3/2,
                  children: [
                    IconButton(
                      onPressed: navigateToPhone,
                      icon: const Icon(Icons.phone_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.chat_bubble_outline),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: navigateToPasses,
                      icon: const Icon(Icons.qr_code_2_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: navigateToWeather,
                      icon: const Icon(Icons.wb_sunny_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: navigateToChatgpt,
                      icon: const Icon(Icons.bubble_chart_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.notes_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                  ],
                ),
            ),
            Center(
              child:
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 3/2,
                  children: [
                    IconButton(
                      onPressed: navigateToMfa,
                      icon: const Icon(Icons.security_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: navigateToSettings,
                      icon: const Icon(Icons.app_settings_alt_outlined),
                      iconSize: 75,
                      color: useDarkTheme ? Colors.white : Colors.black,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                  ],
                ),
            )
          ],
        ),
        backgroundColor: useDarkTheme ? Colors.black : Colors.white,
      ),
    );
  }

  void navigateToPhone() {
    final route = MaterialPageRoute(
      builder: (context) => Phone(),
    );
    Navigator.push(context, route);
  }

  void navigateToPasses() {
    final route = MaterialPageRoute(
      builder: (context) => Passes(),
    );
    Navigator.push(context, route);
  }

  void navigateToChatgpt() {
    final route = MaterialPageRoute(
      builder: (context) => Chatgpt(),
    );
    Navigator.push(context, route);
  }

  void navigateToMfa() {
    final route = MaterialPageRoute(
      builder: (context) => Mfa(),
    );
    Navigator.push(context, route);
  }

  void navigateToWeather() {
    final route = MaterialPageRoute(
      builder: (context) => Weather(),
    );
    Navigator.push(context, route);
  }

  void navigateToSettings() {
    final route = MaterialPageRoute(
      builder: (context) => Settings(),
    );
    Navigator.push(context, route).then((_) {
      loadPreferences();
    });
  }
}
