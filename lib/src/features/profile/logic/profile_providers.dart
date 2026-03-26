import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/profile/data/profile_repository.dart';
import 'package:nordquest_webapp/src/features/profile/domain/profile_stats.dart';

final profileStatsProvider = Provider<ProfileStats>(
  (ref) => ref.watch(fakeProfileRepositoryProvider).getStats(),
);
