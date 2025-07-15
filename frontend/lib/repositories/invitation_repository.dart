import '../services/api_service.dart';

class InvitationRepository {
  final ApiService apiService;

  InvitationRepository({required this.apiService});

  Future<List<Map<String, dynamic>>> fetchInvitations(String token) {
    return apiService.fetchInvitations(token);
  }

  Future<bool> createInvitation({
    required String token,
    required int projectRoleId,
    required int recipientId,
    String? message,
  }) {
    return apiService.createInvitation(
      token: token,
      projectRoleId: projectRoleId,
      recipientId: recipientId,
      message: message,
    );
  }
} 