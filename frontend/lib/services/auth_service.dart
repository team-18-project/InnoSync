import 'package:dio/dio.dart';
import '../models/auth_models.dart';

class AuthService {
  final Dio dio;
  AuthService(this.dio);

  Future<AuthResponse> login(LoginRequest req) async {
    final response = await dio.post('/api/v1/auth/login', data: req.toJson());
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> signup(SignupRequest req) async {
    final response = await dio.post('/api/v1/auth/signup', data: req.toJson());
    return AuthResponse.fromJson(response.data);
  }

  Future<void> logout(LogoutRequest req) async {
    await dio.post('/api/v1/auth/logout', data: req.toJson());
  }

  Future<TokenResponse> refreshToken(RefreshTokenRequest req) async {
    final response = await dio.post('/api/v1/auth/refresh', data: req.toJson());
    return TokenResponse.fromJson(response.data);
  }
} 