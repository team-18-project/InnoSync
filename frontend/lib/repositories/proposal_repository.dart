import '../services/api_service.dart';

class ProposalRepository {
  final ApiService apiService;

  ProposalRepository({required this.apiService});

  Future<List<Map<String, dynamic>>> fetchProposals(String token) {
    return apiService.fetchProposals(token);
  }
} 