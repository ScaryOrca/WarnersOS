import 'package:flutter/material.dart';
import 'package:warnersos/widgets/screen.dart';

class ChatgptConversation extends StatefulWidget {
  const ChatgptConversation({super.key});

  @override
  State<ChatgptConversation> createState() => _ChatgptConversationState();
}

class _ChatgptConversationState extends State<ChatgptConversation> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'New Conversation', 
      children: [],
    );
  }
}