import 'dart:async';

import 'package:nordquest_webapp/src/features/auth/domain/app_user.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  AppUser? _currentUser;
  final _controller = StreamController<AppUser?>.broadcast();

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> watchAuthState() => _controller.stream;

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    _currentUser = AppUser(id: 'fake-user-1', email: email);
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }
}
