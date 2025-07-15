import 'package:flutter/material.dart';
import '../repositories/chat_repository.dart';

class ChatsTab extends StatefulWidget {
  final String token;
  final ChatRepository chatRepository;

  const ChatsTab({
    super.key,
    required this.token,
    required this.chatRepository,
  });

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  late Future<List<Map<String, dynamic>>> _chatsFuture;

  @override
  void initState() {
    super.initState();
    _chatsFuture = widget.chatRepository.fetchChats(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _chatsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load chats'));
        }
        final chats = snapshot.data ?? [];
        if (chats.isEmpty) {
          return const Center(child: Text('No chats found'));
        }
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              title: Text(chat['title'] ?? ''),
              subtitle: Text(chat['last_message'] ?? ''),
            );
          },
        );
      },
    );
  }
} 