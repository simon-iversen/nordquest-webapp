import 'package:nordquest_webapp/src/features/auth/domain/app_user.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    _currentUser = AppUser(id: 'fake-user-1', email: email);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }
}
