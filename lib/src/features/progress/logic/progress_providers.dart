import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/progress/data/progress_repository.dart';
import 'package:nordquest_webapp/src/features/progress/domain/municipality_progress.dart';

final municipalityProgressProvider = Provider<List<MunicipalityProgress>>(
  (ref) =>
      ref.watch(fakeProgressRepositoryProvider).getMunicipalityProgress(),
);
