import 'package:flutter_test/flutter_test.dart';
import 'package:nordquest_webapp/src/features/auth/data/fake_auth_repository.dart';
import 'package:nordquest_webapp/src/features/map/data/fake_map_repository.dart';
import 'package:nordquest_webapp/src/features/profile/data/fake_profile_repository.dart';
import 'package:nordquest_webapp/src/features/progress/data/fake_progress_repository.dart';

void main() {
  group('FakeMapRepository', () {
    final repository = FakeMapRepository();

    test('returns seeded municipalities, trails, and huts', () {
      final municipalities = repository.getMunicipalities();
      final trails = repository.getTrails();
      final huts = repository.getHuts();

      expect(municipalities, isNotEmpty);
      expect(trails, isNotEmpty);
      expect(huts, isNotEmpty);
      expect(municipalities.first.name, 'Oslo');
      expect(trails.where((trail) => trail.isCompleted), hasLength(3));
      expect(huts.where((hut) => hut.isVisited), hasLength(2));
    });
  });

  group('FakeProgressRepository', () {
    final repository = FakeProgressRepository();

    test('returns municipality progress rows', () {
      final progress = repository.getMunicipalityProgress();

      expect(progress, hasLength(6));
      expect(progress.first.name, 'Oslo');
      expect(progress.last.hutsTotal, 3);
    });
  });

  group('FakeProfileRepository', () {
    final repository = FakeProfileRepository();

    test('returns seeded profile stats', () {
      final stats = repository.getStats();

      expect(stats.municipalitiesVisited, 6);
      expect(stats.trailKm, 142);
      expect(stats.activitiesSynced, 47);
    });
  });

  group('FakeAuthRepository', () {
    test('sign in and sign out updates current user', () async {
      final repository = FakeAuthRepository();

      expect(repository.currentUser, isNull);

      final user = await repository.signIn(
        email: 'simon@example.com',
        password: 'secret',
      );

      expect(user.email, 'simon@example.com');
      expect(repository.currentUser?.id, 'fake-user-1');

      await repository.signOut();

      expect(repository.currentUser, isNull);
    });
  });
}
