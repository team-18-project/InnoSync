// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    _TokenResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenType: json['tokenType'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$TokenResponseToJson(_TokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
    };

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: TokenResponse.fromJson(json['tokens'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{'user': instance.user, 'tokens': instance.tokens};

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  password: json['password'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  lastLogin: json['lastLogin'] == null
      ? null
      : DateTime.parse(json['lastLogin'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'fullName': instance.fullName,
  'password': instance.password,
  'createdAt': instance.createdAt?.toIso8601String(),
  'lastLogin': instance.lastLogin?.toIso8601String(),
};

_SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    _SignupRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$SignupRequestToJson(_SignupRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fullName': instance.fullName,
    };

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    _RefreshTokenRequest(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshTokenRequestToJson(
  _RefreshTokenRequest instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

_LogoutRequest _$LogoutRequestFromJson(Map<String, dynamic> json) =>
    _LogoutRequest(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$LogoutRequestToJson(_LogoutRequest instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};
