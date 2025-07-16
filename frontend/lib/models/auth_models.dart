import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required User user,
    required TokenResponse tokens,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String fullName,
    String? password,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class SignupRequest with _$SignupRequest {
  const factory SignupRequest({
    required String email,
    required String password,
    required String fullName,
  }) = _SignupRequest;

  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}

@freezed
class RefreshTokenRequest with _$RefreshTokenRequest {
  const factory RefreshTokenRequest({
    required String refreshToken,
  }) = _RefreshTokenRequest;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestFromJson(json);
}

@freezed
class LogoutRequest with _$LogoutRequest {
  const factory LogoutRequest({
    required String refreshToken,
  }) = _LogoutRequest;

  factory LogoutRequest.fromJson(Map<String, dynamic> json) => _$LogoutRequestFromJson(json);
} 