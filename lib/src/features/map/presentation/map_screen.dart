import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';
import 'package:nordquest_webapp/src/features/map/logic/map_providers.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/hut_marker.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/municipality_popup.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/overall_progress_widget.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final LayerHitNotifier<Municipality> _hitNotifier = ValueNotifier(null);
  Municipality? _selectedMuni;
  Offset? _popupOffset;

  @override
  void dispose() {
    _hitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final municipalities = ref.watch(municipalitiesProvider);
    final trails = ref.watch(trailsProvider);
    final huts = ref.watch(hutsProvider);

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(65.0, 15.0),
            initialZoom: 5.0,
            onTap: (tapPosition, point) {
              final hit = _hitNotifier.value;
              final relative = tapPosition.relative;
              if (hit != null && hit.hitValues.isNotEmpty && relative != null) {
                setState(() {
                  _selectedMuni = hit.hitValues.first;
                  _popupOffset = relative;
                });
              } else {
                setState(() {
                  _selectedMuni = null;
                  _popupOffset = null;
                });
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'no.nordquest.webapp',
            ),
            PolygonLayer<Municipality>(
              hitNotifier: _hitNotifier,
              polygons: municipalities.map((m) {
                final col = municipalityColor(m.completionPercent);
                return Polygon<Municipality>(
                  points: m.polygon,
                  color: col.withOpacity(0.4),
                  borderColor: col,
                  borderStrokeWidth: 2.0,
                  hitValue: m,
                );
              }).toList(),
            ),
            PolylineLayer(
              polylines: trails.map((t) {
                if (t.isCompleted) {
                  return Polyline(
                    points: t.points,
                    color: const Color(0xFF2DB060),
                    strokeWidth: 3.5,
                  );
                } else {
                  return Polyline(
                    points: t.points,
                    color: const Color(0xFF9E9E9E),
                    strokeWidth: 2.0,
                    pattern: StrokePattern.dashed(segments: [10.0, 8.0]),
                  );
                }
              }).toList(),
            ),
            MarkerLayer(
              markers: huts
                  .map(
                    (h) => Marker(
                      point: LatLng(h.lat, h.lng),
                      width: 26,
                      height: 26,
                      child: HutMarker(visited: h.isVisited),
                    ),
                  )
                  .toList(),
            ),
            const RichAttributionWidget(
              alignment: AttributionAlignment.bottomRight,
              showFlutterMapAttribution: false,
              attributions: [
                TextSourceAttribution('© OpenStreetMap contributors'),
              ],
            ),
          ],
        ),
        const Positioned(
          bottom: 40,
          right: 16,
          child: OverallProgressWidget(),
        ),
        if (_selectedMuni != null && _popupOffset != null)
          _buildPopup(_selectedMuni!, _popupOffset!),
      ],
    );
  }

  Widget _buildPopup(Municipality muni, Offset tapPos) {
    const double popupH = 152.0;
    final double left = tapPos.dx + 12;
    final double top = (tapPos.dy - popupH - 12).clamp(4.0, double.infinity);
    return Positioned(
      left: left,
      top: top,
      child: MunicipalityPopup(municipality: muni),
    );
  }
}
