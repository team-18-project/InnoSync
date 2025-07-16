import 'package:dio/dio.dart';
import '../models/invitation_model.dart';

class InvitationService {
  final Dio dio;
  InvitationService(this.dio);

  Future<List<InvitationResponse>> getReceivedInvitations() async {
    final response = await dio.get('/api/v1/invitations/received');
    return (response.data as List)
        .map((e) => InvitationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<InvitationResponse>> getSentInvitations() async {
    final response = await dio.get('/api/v1/invitations/sent');
    return (response.data as List)
        .map((e) => InvitationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createInvitation(CreateInvitationRequest req) async {
    await dio.post('/api/v1/invitations', data: req.toJson());
  }

  Future<void> respondToInvitation(int id, RespondInvitationRequest req) async {
    await dio.patch('/api/v1/invitations/$id/respond', data: req.toJson());
  }
} 