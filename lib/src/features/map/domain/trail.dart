import 'package:latlong2/latlong.dart';

class Trail {
  final String id;
  final String name;
  final List<LatLng> points;
  final bool isCompleted;

  const Trail({
    required this.id,
    required this.name,
    required this.points,
    required this.isCompleted,
  });
}
