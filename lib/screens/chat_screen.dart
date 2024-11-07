import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'messages_screen.dart';

class ChatScreen extends StatelessWidget {
  final Contact contact;

  ChatScreen({required this.contact});

  final List<Message> messages = [
    Message(content: 'Bonjour, comment allez-vous ?', isSentByMe: true),
    Message(content: 'Très bien, merci ! Et vous ?', isSentByMe: false),
    Message(content: 'Je vous contacte pour discuter du poste.', isSentByMe: true),
    Message(content: 'Je suis disponible pour une discussion.', isSentByMe: false),
    // Ajoute d'autres messages ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${contact.firstName} ${contact.lastName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: message.isSentByMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: message.isSentByMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Écrivez un message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Action d'envoi de message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String content;
  final bool isSentByMe;

  Message({required this.content, required this.isSentByMe});
}
