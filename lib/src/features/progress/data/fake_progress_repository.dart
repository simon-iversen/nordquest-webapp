import 'package:nordquest_webapp/src/features/progress/domain/municipality_progress.dart';
import 'progress_repository.dart';

class FakeProgressRepository implements ProgressRepository {
  @override
  List<MunicipalityProgress> getMunicipalityProgress() => const [
        MunicipalityProgress(
          name: 'Oslo',
          hikingPercent: 34,
          skiPercent: 12,
          hutsVisited: 2,
          hutsTotal: 8,
        ),
        MunicipalityProgress(
          name: 'Bergen',
          hikingPercent: 51,
          skiPercent: 5,
          hutsVisited: 4,
          hutsTotal: 11,
        ),
        MunicipalityProgress(
          name: 'Tromsø',
          hikingPercent: 18,
          skiPercent: 42,
          hutsVisited: 1,
          hutsTotal: 6,
        ),
        MunicipalityProgress(
          name: 'Trondheim',
          hikingPercent: 27,
          skiPercent: 31,
          hutsVisited: 3,
          hutsTotal: 9,
        ),
        MunicipalityProgress(
          name: 'Lillehammer',
          hikingPercent: 63,
          skiPercent: 78,
          hutsVisited: 5,
          hutsTotal: 7,
        ),
        MunicipalityProgress(
          name: 'Ullensaker',
          hikingPercent: 9,
          skiPercent: 22,
          hutsVisited: 0,
          hutsTotal: 3,
        ),
      ];
}
