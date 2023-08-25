import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async{
    
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();
    // send to FIrebase 
    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .get();

    final data = userData.data() as Map<String, dynamic>;
    
     FirebaseFirestore.instance.collection('chat').add({
      'chat': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': data['username'],
      'userImage': data['image_url'],

    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: true,
            autocorrect: true,
            decoration: const InputDecoration(
              labelText: 'send message',
            ),
          )),
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: _submitMessage,
              icon: const Icon(Icons.send)),
        ],
      ),
    );
  }
}
