import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen extends StatefulWidget {
  // Widget Parameters
  final String title;
  final List<Widget> children;
  final bool? forceDarkTheme;
  final VoidCallback? settingsScreen;
  final VoidCallback? editScreen;
  final MainAxisAlignment? mainAxisAlignment;
  final Widget? bottomAttachment;


  const Screen({super.key, required this.title, required this.children, this.forceDarkTheme, this.settingsScreen, this.editScreen, this.mainAxisAlignment, this.bottomAttachment});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final buttonPressChannel = const MethodChannel('com.warnersnotes.warnersos/buttonPress');
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
    buttonPressChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'volume_up':
          print('Volume Up Button Pressed');
          break;
        case 'volume_down':
          print('Volume Down Button Pressed');
          break;
        case '0':
          Navigator.of(context).pop();
        default:
          print(call.method);
        // Handle other keys...
      }
    });

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child:
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: Text(widget.title, style: TextStyle(fontSize: 40, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black)),
                    centerTitle: true,
                    toolbarHeight: 75,
                    pinned: true,
                    backgroundColor: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.black : Colors.white,
                    leading: 
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close_outlined, size: 50, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black,),
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        alignment: Alignment.center,
                      ),
                    actions: [
                      if (widget.settingsScreen != null) ...[
                        IconButton(
                          icon: Icon(Icons.settings_outlined, size: 50, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black,),
                          onPressed: widget.settingsScreen,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          alignment: Alignment.center,
                        ),
                      ] else if (widget.editScreen != null) ...[
                        IconButton(
                          icon: Icon(Icons.edit_outlined, size: 50, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black,),
                          onPressed: widget.editScreen,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          alignment: Alignment.center,
                        ),
                      ],
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var child in widget.children) child,
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              )
          ),
          if (widget.bottomAttachment != null) ...[
            Container(
              child: widget.bottomAttachment,
            ),
          ],
      ]),
        backgroundColor: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.black : Colors.white,
    );
    /*
    return Scaffold(
      body:
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                AppBar(
                  title: Text(widget.title, style: TextStyle(fontSize: 40, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black)),
                  centerTitle: true,
                  toolbarHeight: 75,
                  backgroundColor: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.black : Colors.white,
                  leading: 
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.chevron_left_rounded, size: 50, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black,),
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      alignment: Alignment.center,
                    ),
                  actions: widget.settingsScreen != null ? [
                    IconButton(
                      icon: Icon(Icons.settings_rounded, size: 50, color: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.white : Colors.black,),
                      onPressed: widget.settingsScreen,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      alignment: Alignment.center,
                    ),
                  ] : [],
                ),
                for (var child in widget.children) child,
              ],
            ),
        backgroundColor: (useDarkTheme && widget.forceDarkTheme != false || widget.forceDarkTheme == true) ? Colors.black : Colors.white,
    );
    */
  }
}