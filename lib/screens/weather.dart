import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/screens/weather_settings.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final String apiKey = '59d53fe373a4420280f221824242705';
  late String weatherLocation = '';
  late String temperature = 'Loading...';
  late String locationName = '';
  late String weatherCondition = '';
  late String regionName = '';
  late bool useDarkTheme = false;

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

    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Weather',
      children: [
        Column(
          children: [
            if (locationName != '') ...[
              Text(locationName, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: useDarkTheme ? Colors.white : Colors.black),),
              Text(regionName, style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black),),
              const SizedBox(height: 20),
            ],

            if (weatherLocation != '') ...[
              Text(temperature, style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black)),
              const SizedBox(height: 20),
            ] else ...[
              Text('Location not set.', style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black)),
            ],

            if (weatherCondition != '') ...[
              Text(weatherCondition, style: TextStyle(fontSize: 30, color: useDarkTheme ? Colors.white : Colors.black),),
            ],
          ],
        ),
      ],
      settingsScreen: navigateToSettings,
    );
  }

  void navigateToSettings() {
    final route = MaterialPageRoute(
      builder: (context) => WeatherSettings(),
    );
    Navigator.push(context, route).then((_) {
      loadPreferences();
    });
  }

  void fetchWeather() async {
    final url = 'https://api.weatherapi.com/v1/current.json?key=' + apiKey + '&q=' + weatherLocation + '&aqi=no';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      var decodedBody = jsonDecode(response.body);
      
      setState(() {
        temperature = decodedBody['current']['temp_f'].toString() + '°';
        weatherCondition = decodedBody['current']['condition']['text'];
        locationName = decodedBody['location']['name'];
        regionName = decodedBody['location']['region'];
      });
    }
  }
}