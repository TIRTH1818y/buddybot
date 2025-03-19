import 'package:flutter/material.dart';

class ChatHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> chatMessages;

  const ChatHistoryScreen(this.chatMessages, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        title: const Text('Chat History'),
        backgroundColor: Colors.cyan.shade800,
      ),
      body: ListView.separated(
        itemCount: chatMessages.length,
        separatorBuilder: (context, index) => const Divider(color: Colors.white70),
        itemBuilder: (context, index) {
          final chat = chatMessages[index];
          final isUser = chat['sender'] == 'user';
          return ListTile(
            title: Text(
              chat['message'] ?? '',
              style: TextStyle(
                color: isUser ? Colors.cyanAccent : Colors.greenAccent,
              ),
            ),
            subtitle: Text(
              isUser ? 'You' : 'Bot',
              style: TextStyle(
                color: isUser ? Colors.yellow : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
