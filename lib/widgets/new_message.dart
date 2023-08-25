import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();
  @override
  void dispose() {
    _messageController.dispose(); 
    super.dispose();
  }

  void _submitMessage(){ 
    final enteredMessage = _messageController.text; 
    if(enteredMessage.trim().isEmpty){
      return;
    }
     // send to FIrebase
     _messageController.clear();  
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _messageController ,
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
