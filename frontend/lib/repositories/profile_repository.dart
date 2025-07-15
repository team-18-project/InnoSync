import '../services/api_service.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  Future<Map<String, dynamic>> fetchProfile(String token) {
    return apiService.fetchProfile(token);
  }

  Future<bool> createProfile({
    required String token,
    required String name,
    required String email,
    String? telegram,
    String? github,
    String? bio,
  }) {
    return apiService.createProfile(
      token: token,
      name: name,
      email: email,
      telegram: telegram,
      github: github,
      bio: bio,
    );
  }
} 