import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/profile/domain/profile_stats.dart';
import 'fake_profile_repository.dart';

abstract class ProfileRepository {
  ProfileStats getStats();
}

final fakeProfileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => FakeProfileRepository(),
);
