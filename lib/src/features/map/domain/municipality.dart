import 'package:latlong2/latlong.dart';

class Municipality {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final int completionPercent;
  final int hikingPercent;
  final int skiPercent;
  final int hutsVisited;
  final int hutsTotal;
  final List<LatLng> polygon;

  const Municipality({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.completionPercent,
    required this.hikingPercent,
    required this.skiPercent,
    required this.hutsVisited,
    required this.hutsTotal,
    required this.polygon,
  });
}
