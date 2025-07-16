import 'package:dio/dio.dart';
import '../models/profile_model.dart';

class ProfileService {
  final Dio dio;
  ProfileService(this.dio);

  Future<UserProfile> getProfile() async {
    final response = await dio.get('/api/v1/profile/me');
    return UserProfile.fromJson(response.data);
  }

  Future<UserProfile> createProfile(CreateProfileRequest req) async {
    final response = await dio.post('/api/v1/profile', data: req.toJson());
    return UserProfile.fromJson(response.data);
  }

  Future<UserProfile> updateProfile(UpdateProfileRequest req) async {
    final response = await dio.put('/api/v1/profile', data: req.toJson());
    return UserProfile.fromJson(response.data);
  }
} 