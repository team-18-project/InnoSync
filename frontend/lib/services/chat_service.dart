import 'package:dio/dio.dart';
import '../models/chat_model.dart';

class ChatService {
  final Dio dio;
  ChatService(this.dio);

  Future<List<GroupChat>> getChats() async {
    final response = await dio.get('/api/v1/chats');
    return (response.data as List)
        .map((e) => GroupChat.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Message>> getMessages(int chatId) async {
    final response = await dio.get('/api/v1/chats/$chatId/messages');
    return (response.data as List)
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> sendMessage(int chatId, String content) async {
    await dio.post('/api/v1/chats/$chatId/messages', data: {'content': content});
  }
} 