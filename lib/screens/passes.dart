import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/database/pass_database.dart';
import 'package:warnersos/models/pass.dart';
import 'package:warnersos/screens/add_pass.dart';
import 'package:warnersos/screens/view_pass.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:warnersos/widgets/screen_button.dart';
import 'package:warnersos/widgets/screen_card.dart';

class Passes extends StatefulWidget {
  const Passes({super.key});

  @override
  State<Passes> createState() => _PassesState();
}

class _PassesState extends State<Passes> {
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
      title: 'Passes',
      children: [
        FutureBuilder<List<Pass>>(
          future: PassDatabaseHelper.instance.getPasses(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Pass>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text(
                      'No passes saved yet.',
                      style:
                        TextStyle(
                          fontSize: 30,
                          color: useDarkTheme ? Colors.white : Colors.black,
                        ),
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map((pass) {
                      return Center(
                        child: ScreenCard(
                          title: pass.title,
                          onTap: () => {
                            navigateToViewPass(pass)
                          },
                        ),
                      );
                    }).toList(),
                  );
          }
        ),
        const SizedBox(height: 40),
        ScreenButton(
          onPressed: navigateToAddPass,
          text: 'Add Pass',
        ),
      ],
    );
  }

  void navigateToAddPass() {
    final route = MaterialPageRoute(
      builder: (context) => AddPass(),
    );
    Navigator.push(context, route);
  }

  void navigateToViewPass(Pass pass) {
    final route = MaterialPageRoute(
      builder: (context) => ViewPass(pass: pass),
    );
    Navigator.push(context, route);
  }
}