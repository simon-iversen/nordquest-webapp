import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/features/progress/domain/municipality_progress.dart';
import 'fake_progress_repository.dart';

abstract class ProgressRepository {
  List<MunicipalityProgress> getMunicipalityProgress();
}

final fakeProgressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => FakeProgressRepository(),
);
