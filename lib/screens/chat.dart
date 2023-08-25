import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemythree/widgets/chat_messeges.dart';
import 'package:udemythree/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Chat app',),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(children: const [
        Expanded(child: ChatMessages()),
        NewMessage(),
      ]),
    );
  }
}
