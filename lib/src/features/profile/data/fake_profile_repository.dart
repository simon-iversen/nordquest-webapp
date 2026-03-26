import 'package:nordquest_webapp/src/features/profile/domain/profile_stats.dart';
import 'profile_repository.dart';

class FakeProfileRepository implements ProfileRepository {
  @override
  ProfileStats getStats() => const ProfileStats(
        municipalitiesVisited: 6,
        trailKm: 142,
        hutsCheckedIn: 3,
        activitiesSynced: 47,
      );
}
