import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnersos/screens/chatgpt_settings.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:http/http.dart' as http;
import 'package:warnersos/widgets/screen_textfield.dart';

class Chatgpt extends StatefulWidget {
  const Chatgpt({super.key});

  @override
  State<Chatgpt> createState() => _ChatgptState();
}

class _ChatgptState extends State<Chatgpt> {
  late String openAiApiKey = '';
  List<dynamic> chatSession = [];
  bool isLoading = false;

  TextEditingController promptController = TextEditingController();

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  void loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      openAiApiKey = prefs.getString('openAiApiKey') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'ChatGPT',
      settingsScreen: navigateToSettings,
      bottomAttachment: Padding(
          padding: EdgeInsets.all(20),
          child:
            ScreenTextfield(
              hintText: 'Prompt',
              onSubmitted: submitPrompt,
            ),
        ),
      children: [
        if (chatSession.isEmpty) ... [
          const Text(
            'Enter a prompt to get started',
            style: TextStyle(fontSize: 18, color: Colors.black,),
            textAlign: TextAlign.left,
          ),
        ] else ...[
          for (var message in chatSession) ...[
            if (message['role'] == 'assistant') ...[
              const SizedBox(height: 20),
              Text(
                message['content'],
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ] else ...[
              Text(
                message['content'],
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ],
          if (isLoading) ...[
            const Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ],
      ],
    );
  }

  void submitPrompt(String prompt) async {
    final url = 'https://api.openai.com/v1/chat/completions';
    final uri = Uri.parse(url);
    List<dynamic>unsavedChatSession = chatSession;

    unsavedChatSession.add({
      'role': 'user',
      'content': prompt,
    });

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + openAiApiKey,
      },
      body: jsonEncode({
        'model': 'gpt-4o',
        'messages': unsavedChatSession,
      }),
    );

    if (response.statusCode == 200) {
      unsavedChatSession.add({
        'role': 'assistant',
        'content': jsonDecode(response.body)['choices'][0]['message']['content'],
      });

      setState(() {
        chatSession = unsavedChatSession;
        promptController.text = '';
        isLoading = false;
      });
    }
    print(response.body);
  }

  void navigateToSettings() {
    final route = MaterialPageRoute(
      builder: (context) => ChatgptSettings(),
    );
    Navigator.push(context, route).then((_) {
      loadPreferences();
    });
  }
}