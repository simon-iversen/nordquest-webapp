import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/auth/data/auth_repository.dart';
import 'package:nordquest_webapp/src/features/auth/domain/app_user.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository _repository;

  AuthNotifier(this._repository);

  AppUser? get currentUser => _repository.currentUser;
  bool get isLoggedIn => _repository.currentUser != null;
  String get email => _repository.currentUser?.email ?? '';

  Future<void> login(String email, String password) async {
    await _repository.signIn(email: email, password: password);
    notifyListeners();
  }

  Future<void> logout() async {
    await _repository.signOut();
    notifyListeners();
  }
}

final authNotifierProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) => AuthNotifier(ref.read(fakeAuthRepositoryProvider)),
);

final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authNotifierProvider).currentUser,
);
