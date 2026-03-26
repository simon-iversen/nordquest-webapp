import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/features/map/domain/hut.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';
import 'package:nordquest_webapp/src/features/map/domain/trail.dart';
import 'map_repository.dart';

class FakeMapRepository implements MapRepository {
  @override
  List<Municipality> getMunicipalities() => const [
        Municipality(
          id: 'oslo',
          name: 'Oslo',
          lat: 59.91,
          lng: 10.75,
          completionPercent: 34,
          hikingPercent: 34,
          skiPercent: 18,
          hutsVisited: 2,
          hutsTotal: 8,
          polygon: [
            LatLng(59.80, 10.50),
            LatLng(60.02, 10.50),
            LatLng(60.02, 10.95),
            LatLng(59.80, 10.95),
          ],
        ),
        Municipality(
          id: 'bergen',
          name: 'Bergen',
          lat: 60.39,
          lng: 5.32,
          completionPercent: 12,
          hikingPercent: 12,
          skiPercent: 3,
          hutsVisited: 1,
          hutsTotal: 7,
          polygon: [
            LatLng(60.25, 5.10),
            LatLng(60.55, 5.10),
            LatLng(60.55, 5.55),
            LatLng(60.25, 5.55),
          ],
        ),
        Municipality(
          id: 'tromso',
          name: 'Tromsø',
          lat: 69.65,
          lng: 18.96,
          completionPercent: 67,
          hikingPercent: 67,
          skiPercent: 45,
          hutsVisited: 3,
          hutsTotal: 5,
          polygon: [
            LatLng(69.50, 18.70),
            LatLng(69.85, 18.70),
            LatLng(69.85, 19.30),
            LatLng(69.50, 19.30),
          ],
        ),
        Municipality(
          id: 'trondheim',
          name: 'Trondheim',
          lat: 63.43,
          lng: 10.39,
          completionPercent: 8,
          hikingPercent: 8,
          skiPercent: 5,
          hutsVisited: 0,
          hutsTotal: 6,
          polygon: [
            LatLng(63.30, 10.20),
            LatLng(63.55, 10.20),
            LatLng(63.55, 10.65),
            LatLng(63.30, 10.65),
          ],
        ),
        Municipality(
          id: 'ullensaker',
          name: 'Ullensaker',
          lat: 60.15,
          lng: 11.10,
          completionPercent: 45,
          hikingPercent: 45,
          skiPercent: 30,
          hutsVisited: 2,
          hutsTotal: 4,
          polygon: [
            LatLng(60.05, 11.00),
            LatLng(60.30, 11.00),
            LatLng(60.30, 11.40),
            LatLng(60.05, 11.40),
          ],
        ),
        Municipality(
          id: 'lillehammer',
          name: 'Lillehammer',
          lat: 61.12,
          lng: 10.47,
          completionPercent: 23,
          hikingPercent: 23,
          skiPercent: 40,
          hutsVisited: 1,
          hutsTotal: 5,
          polygon: [
            LatLng(61.05, 10.30),
            LatLng(61.25, 10.30),
            LatLng(61.25, 10.65),
            LatLng(61.05, 10.65),
          ],
        ),
        Municipality(
          id: 'bodo',
          name: 'Bodø',
          lat: 67.28,
          lng: 14.38,
          completionPercent: 5,
          hikingPercent: 5,
          skiPercent: 2,
          hutsVisited: 0,
          hutsTotal: 4,
          polygon: [
            LatLng(67.20, 14.25),
            LatLng(67.45, 14.25),
            LatLng(67.45, 14.80),
            LatLng(67.20, 14.80),
          ],
        ),
        Municipality(
          id: 'stavanger',
          name: 'Stavanger',
          lat: 58.97,
          lng: 5.73,
          completionPercent: 19,
          hikingPercent: 19,
          skiPercent: 4,
          hutsVisited: 1,
          hutsTotal: 6,
          polygon: [
            LatLng(58.85, 5.55),
            LatLng(59.10, 5.55),
            LatLng(59.10, 5.95),
            LatLng(58.85, 5.95),
          ],
        ),
      ];

  @override
  List<Trail> getTrails() => const [
        Trail(
          id: 't1',
          name: 'Oslo Forest Trail 1',
          points: [LatLng(59.9750, 10.7260), LatLng(59.9900, 10.6700)],
          isCompleted: true,
        ),
        Trail(
          id: 't2',
          name: 'Oslo Forest Trail 2',
          points: [LatLng(59.9900, 10.6700), LatLng(60.0050, 10.6650)],
          isCompleted: true,
        ),
        Trail(
          id: 't3',
          name: 'Oslo Forest Trail 3',
          points: [LatLng(60.0050, 10.6650), LatLng(60.0370, 10.6190)],
          isCompleted: true,
        ),
        Trail(
          id: 't4',
          name: 'Oslo Forest Trail 4',
          points: [LatLng(60.0370, 10.6190), LatLng(60.0600, 10.5880)],
          isCompleted: false,
        ),
        Trail(
          id: 't5',
          name: 'Oslo Forest Trail 5',
          points: [LatLng(60.0600, 10.5880), LatLng(60.0850, 10.5550)],
          isCompleted: false,
        ),
        Trail(
          id: 't6',
          name: 'Oslo Forest Trail 6',
          points: [LatLng(59.9750, 10.7260), LatLng(59.9600, 10.7800)],
          isCompleted: false,
        ),
      ];

  @override
  List<Hut> getHuts() => const [
        Hut(
          id: 'h1',
          name: 'Ullevålseter',
          lat: 60.0050,
          lng: 10.6650,
          isVisited: true,
        ),
        Hut(
          id: 'h2',
          name: 'Kikutstua',
          lat: 60.0370,
          lng: 10.6190,
          isVisited: true,
        ),
        Hut(
          id: 'h3',
          name: 'Kobberhaughytta',
          lat: 60.0600,
          lng: 10.5880,
          isVisited: false,
        ),
        Hut(
          id: 'h4',
          name: 'Frognerseteren',
          lat: 59.9840,
          lng: 10.6500,
          isVisited: false,
        ),
      ];
}
