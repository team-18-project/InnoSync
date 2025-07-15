import '../services/api_service.dart';

class ChatRepository {
  final ApiService apiService;

  ChatRepository({required this.apiService});

  Future<List<Map<String, dynamic>>> fetchChats(String token) {
    return apiService.fetchChats(token);
  }
} 