import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/map/domain/hut.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';
import 'package:nordquest_webapp/src/features/map/domain/trail.dart';
import 'fake_map_repository.dart';

abstract class MapRepository {
  List<Municipality> getMunicipalities();
  List<Trail> getTrails();
  List<Hut> getHuts();
}

final fakeMapRepositoryProvider = Provider<MapRepository>(
  (ref) => FakeMapRepository(),
);
