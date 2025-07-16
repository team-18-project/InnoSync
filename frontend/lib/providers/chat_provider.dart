import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat_model.dart';
import '../services/chat_service.dart';
import 'dio_provider.dart';

part 'chat_provider.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  Future<List<GroupChat>> build() async {
    final service = ChatService(ref.read(dioProvider));
    return await service.getChats();
  }

  Future<List<Message>> getMessages(int chatId) async {
    final service = ChatService(ref.read(dioProvider));
    return await service.getMessages(chatId);
  }

  Future<void> sendMessage(int chatId, String content) async {
    final service = ChatService(ref.read(dioProvider));
    await service.sendMessage(chatId, content);
  }
} 