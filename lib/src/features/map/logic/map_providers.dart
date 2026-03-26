import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/map/data/map_repository.dart';
import 'package:nordquest_webapp/src/features/map/domain/hut.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';
import 'package:nordquest_webapp/src/features/map/domain/trail.dart';

final municipalitiesProvider = Provider<List<Municipality>>(
  (ref) => ref.watch(fakeMapRepositoryProvider).getMunicipalities(),
);

final trailsProvider = Provider<List<Trail>>(
  (ref) => ref.watch(fakeMapRepositoryProvider).getTrails(),
);

final hutsProvider = Provider<List<Hut>>(
  (ref) => ref.watch(fakeMapRepositoryProvider).getHuts(),
);
