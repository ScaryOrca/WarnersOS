import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:warnersos/widgets/screen_button.dart';
import 'package:warnersos/widgets/screen_textfield.dart';

class ChatgptSettings extends StatefulWidget {
  const ChatgptSettings({super.key});

  @override
  State<ChatgptSettings> createState() => _ChatgptSettingsState();
}

class _ChatgptSettingsState extends State<ChatgptSettings> {
  late String openAiApiKey = '';
  late bool useDarkTheme = false;

  TextEditingController apiKeyController = TextEditingController();

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      openAiApiKey = prefs.getString('openAiApiKey') ?? '';
      useDarkTheme = prefs.getBool('useDarkTheme') ?? false;
    });

    apiKeyController.text = openAiApiKey;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Settings',
      children: [
        ScreenTextfield(
          controller: apiKeyController,
          hintText: 'OpenAI API Key',
        ),
        const SizedBox(height: 40),
        ScreenButton(
          text: 'Save Settings',
          onPressed: saveChatgptSettings,
        ),
      ],
    );
  }

  void saveChatgptSettings() async {
    final apiKey = apiKeyController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      openAiApiKey = apiKey;
      prefs.setString('openAiApiKey', apiKey);
    });

    Navigator.of(context).pop();
  }
}