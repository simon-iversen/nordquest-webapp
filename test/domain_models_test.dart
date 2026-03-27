import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/features/auth/domain/app_user.dart';
import 'package:nordquest_webapp/src/features/map/domain/hut.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';
import 'package:nordquest_webapp/src/features/map/domain/trail.dart';
import 'package:nordquest_webapp/src/features/profile/domain/profile_stats.dart';
import 'package:nordquest_webapp/src/features/progress/domain/municipality_progress.dart';

void main() {
  test('AppUser stores id and email', () {
    const user = AppUser(id: 'user-1', email: 'simon@example.com');

    expect(user.id, 'user-1');
    expect(user.email, 'simon@example.com');
  });

  test('Trail stores route points and completion flag', () {
    const trail = Trail(
      id: 'trail-1',
      name: 'Test Trail',
      points: [LatLng(60.0, 11.0), LatLng(60.1, 11.1)],
      isCompleted: true,
    );

    expect(trail.points, hasLength(2));
    expect(trail.isCompleted, isTrue);
    expect(trail.name, contains('Test'));
  });

  test('Municipality stores completion details and polygon', () {
    const municipality = Municipality(
      id: 'ullensaker',
      name: 'Ullensaker',
      lat: 60.15,
      lng: 11.1,
      completionPercent: 45,
      hikingPercent: 45,
      skiPercent: 30,
      hutsVisited: 2,
      hutsTotal: 4,
      polygon: [
        LatLng(60.0, 11.0),
        LatLng(60.2, 11.0),
        LatLng(60.2, 11.2),
      ],
    );

    expect(municipality.completionPercent, 45);
    expect(municipality.hutsVisited, 2);
    expect(municipality.polygon, hasLength(3));
  });

  test('Hut stores visited state', () {
    const hut = Hut(
      id: 'hut-1',
      name: 'Kikutstua',
      lat: 60.03,
      lng: 10.61,
      isVisited: true,
    );

    expect(hut.name, 'Kikutstua');
    expect(hut.isVisited, isTrue);
  });

  test('MunicipalityProgress stores activity progress fields', () {
    const progress = MunicipalityProgress(
      name: 'Oslo',
      hikingPercent: 34,
      skiPercent: 12,
      hutsVisited: 2,
      hutsTotal: 8,
    );

    expect(progress.skiPercent, 12);
    expect(progress.hutsTotal - progress.hutsVisited, 6);
  });

  test('ProfileStats stores aggregate profile metrics', () {
    const stats = ProfileStats(
      municipalitiesVisited: 6,
      trailKm: 142,
      hutsCheckedIn: 3,
      activitiesSynced: 47,
    );

    expect(stats.municipalitiesVisited, greaterThan(0));
    expect(stats.trailKm, 142);
    expect(stats.hutsCheckedIn, 3);
  });
}
