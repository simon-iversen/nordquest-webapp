import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/auth/domain/app_user.dart';
import 'fake_auth_repository.dart';

abstract class AuthRepository {
  AppUser? get currentUser;
  Future<AppUser> signIn({required String email, required String password});
  Future<void> signOut();
}

final fakeAuthRepositoryProvider = Provider<AuthRepository>(
  (ref) => FakeAuthRepository(),
);
