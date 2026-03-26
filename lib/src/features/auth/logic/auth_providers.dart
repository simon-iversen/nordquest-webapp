import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/auth/data/auth_repository.dart';
import 'package:nordquest_webapp/src/features/auth/domain/app_user.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository _repository;
  StreamSubscription<AppUser?>? _authSub;

  AuthNotifier(this._repository) {
    _authSub = _repository.watchAuthState().listen((_) {
      notifyListeners();
    });
  }

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

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}

final authNotifierProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) => AuthNotifier(ref.read(authRepositoryProvider)),
);

final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authNotifierProvider).currentUser,
);
