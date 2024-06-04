import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:warnersos/widgets/screen_button.dart';
import 'package:warnersos/widgets/screen_textfield.dart';

class WeatherSettings extends StatefulWidget {
  const WeatherSettings({super.key});

  @override
  State<WeatherSettings> createState() => _WeatherSettingsState();
}

class _WeatherSettingsState extends State<WeatherSettings> {
  late String weatherLocation = '';
  late bool useDarkTheme = false;

  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      weatherLocation = prefs.getString('weatherLocation') ?? '';
      useDarkTheme = prefs.getBool('useDarkTheme') ?? false;
    });

    locationController.text = weatherLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Settings',
      children: [
        ScreenTextfield(
          controller: locationController,
          hintText: 'Location',
        ),
        const SizedBox(height: 40),
        ScreenButton(
          onPressed: saveWeatherSettings,
          text: 'Save Settings'
        ),
      ],
    );
  }

  void saveWeatherSettings() async {
    final location = locationController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      weatherLocation = location;
      prefs.setString('weatherLocation', location);
    });

    Navigator.of(context).pop();
  }
}