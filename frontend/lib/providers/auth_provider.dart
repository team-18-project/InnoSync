import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/auth_models.dart';
import '../services/auth_service.dart';
import 'dio_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthResponse?> build() async => null;

  Future<void> login(LoginRequest req) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = AuthService(ref.read(dioProvider));
      return await service.login(req);
    });
  }

  Future<void> signup(SignupRequest req) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = AuthService(ref.read(dioProvider));
      return await service.signup(req);
    });
  }

  Future<void> logout(LogoutRequest req) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = AuthService(ref.read(dioProvider));
      await service.logout(req);
      return null;
    });
  }
} 