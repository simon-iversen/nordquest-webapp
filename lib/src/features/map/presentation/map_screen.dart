import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';
import 'package:nordquest_webapp/src/features/map/logic/map_providers.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/adventure_preview_panel.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/explore_highlights_panel.dart';
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
  final MapController _mapController = MapController();
  Municipality? _selectedMuni;
  Offset? _popupOffset;
  ExploreHighlight? _selectedHighlight;
  ExploreVibe _selectedVibe = ExploreVibe.all;
  ExploreEffort _selectedEffort = ExploreEffort.all;

  static const List<ExploreHighlight> _highlights = [
    ExploreHighlight(
      title: 'Lyngen Alps weekend',
      subtitle:
          'Sharp ridgelines, a glowing fjord backdrop, and a hut stop that feels properly Arctic.',
      badge: 'Mock route',
      detail: '2 hikes + 1 hut + big summit energy',
      duration: '2 days / 1 basecamp',
      bestFor: 'Ridges + fjord views',
      whyItWorks:
          'It turns the map into a clear weekend idea instead of a blank northern expanse. You instantly get a place, a mood, and a route rhythm.',
      icon: Icons.landscape_rounded,
      center: LatLng(69.55, 19.75),
      zoom: 8.2,
      gradient: [Color(0xFF214E57), Color(0xFF3F7D6A)],
      vibe: ExploreVibe.ridges,
      effort: ExploreEffort.bigDay,
      route: [
        LatLng(69.574, 19.764),
        LatLng(69.618, 19.812),
        LatLng(69.661, 19.928),
      ],
      stops: [
        ExploreStop(
          title: 'Fjord trailhead',
          note:
              'Ease into the weekend with a short climb and instant water-to-peak contrast.',
          icon: Icons.directions_walk_rounded,
          markerColor: Color(0xFF2D6A4F),
          location: LatLng(69.574, 19.764),
        ),
        ExploreStop(
          title: 'Mock hut night',
          note:
              'A fake cozy stop for drying layers, watching late light, and plotting the summit morning.',
          icon: Icons.cottage_rounded,
          markerColor: Color(0xFFB08968),
          location: LatLng(69.618, 19.812),
        ),
        ExploreStop(
          title: 'Ridgeline viewpoint',
          note:
              'The dramatic payoff: open fjord views and that proper Lyngen knife-edge feeling.',
          icon: Icons.photo_camera_back_rounded,
          markerColor: Color(0xFF6D597A),
          location: LatLng(69.661, 19.928),
        ),
      ],
      snapshot: [
        ExploreSnapshotFact(
          label: 'Terrain',
          value: 'Alpine ridgeline',
          icon: Icons.terrain_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Light',
          value: 'Late Arctic glow',
          icon: Icons.wb_twilight_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Flow',
          value: 'Basecamp + summit push',
          icon: Icons.route_rounded,
        ),
      ],
    ),
    ExploreHighlight(
      title: 'Jotunheimen cabin loop',
      subtitle:
          'A simple mock multi-day idea built around lakes, huts, and one iconic high-mountain area.',
      badge: 'Hut trip',
      detail: '3 cabins linked into one neat adventure',
      duration: '3 days / hut-to-hut',
      bestFor: 'Cabins + alpine calm',
      whyItWorks:
          'This gives first-time explorers an understandable shape: start, sleep, move, repeat. The mountains feel approachable instead of overwhelming.',
      icon: Icons.cottage_rounded,
      center: LatLng(61.55, 8.45),
      zoom: 8.0,
      gradient: [Color(0xFF5B7C3F), Color(0xFF8AB17D)],
      vibe: ExploreVibe.cabins,
      effort: ExploreEffort.moderate,
      route: [
        LatLng(61.499, 8.394),
        LatLng(61.546, 8.431),
        LatLng(61.583, 8.519),
        LatLng(61.622, 8.582),
      ],
      stops: [
        ExploreStop(
          title: 'Lake approach',
          note:
              'A gentle first stretch where the landscape opens up without asking too much too early.',
          icon: Icons.water_rounded,
          markerColor: Color(0xFF457B9D),
          location: LatLng(61.499, 8.394),
        ),
        ExploreStop(
          title: 'Cabin one',
          note:
              'Mock overnight with a classic “boots off, soup on” mountain-hut vibe.',
          icon: Icons.cabin_rounded,
          markerColor: Color(0xFF8D6E63),
          location: LatLng(61.546, 8.431),
        ),
        ExploreStop(
          title: 'High plateau crossing',
          note:
              'Open sky, long sightlines, and that spacious Jotunheimen feeling.',
          icon: Icons.terrain_rounded,
          markerColor: Color(0xFF6A994E),
          location: LatLng(61.583, 8.519),
        ),
        ExploreStop(
          title: 'Cabin loop finish',
          note:
              'A tidy finish that makes the whole trip feel achievable and worth repeating.',
          icon: Icons.flag_rounded,
          markerColor: Color(0xFFBC6C25),
          location: LatLng(61.622, 8.582),
        ),
      ],
      snapshot: [
        ExploreSnapshotFact(
          label: 'Terrain',
          value: 'Lake + plateau',
          icon: Icons.landscape_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Pace',
          value: 'Hut-to-hut steady',
          icon: Icons.cabin_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Mood',
          value: 'Calm alpine reset',
          icon: Icons.self_improvement_rounded,
        ),
      ],
    ),
    ExploreHighlight(
      title: 'Lofoten sea-to-summit',
      subtitle:
          'A mock discovery stop for dramatic coastline views and a short trail with maximum payoff.',
      badge: 'Scenic stop',
      detail: 'Coastline drama in one tap',
      duration: 'Half day / photo-heavy',
      bestFor: 'Sea cliffs + payoff',
      whyItWorks:
          'It adds instant delight. One click and the app suggests a punchy coastal adventure that feels specific, cinematic, and easy to imagine.',
      icon: Icons.wb_sunny_outlined,
      center: LatLng(68.23, 13.61),
      zoom: 9.0,
      gradient: [Color(0xFF355070), Color(0xFF6D597A)],
      vibe: ExploreVibe.coast,
      effort: ExploreEffort.easy,
      route: [
        LatLng(68.214, 13.584),
        LatLng(68.236, 13.613),
        LatLng(68.252, 13.655),
      ],
      stops: [
        ExploreStop(
          title: 'Beach start',
          note:
              'Begin near the sand with sea spray, low effort, and immediate postcard energy.',
          icon: Icons.beach_access_rounded,
          markerColor: Color(0xFF3D5A80),
          location: LatLng(68.214, 13.584),
        ),
        ExploreStop(
          title: 'Steady climb',
          note:
              'A short mock ascent where every switchback reveals more coastline.',
          icon: Icons.hiking_rounded,
          markerColor: Color(0xFF588157),
          location: LatLng(68.236, 13.613),
        ),
        ExploreStop(
          title: 'Sea-to-summit viewpoint',
          note:
              'The compact payoff: jagged peaks, open ocean, and very little ambiguity about why you came.',
          icon: Icons.visibility_rounded,
          markerColor: Color(0xFF9C6644),
          location: LatLng(68.252, 13.655),
        ),
      ],
      snapshot: [
        ExploreSnapshotFact(
          label: 'Terrain',
          value: 'Beach to peak',
          icon: Icons.waves_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Payoff',
          value: 'Big photos fast',
          icon: Icons.photo_camera_back_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Feel',
          value: 'Punchy half-day',
          icon: Icons.flash_on_rounded,
        ),
      ],
    ),
  ];

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
          mapController: _mapController,
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
                  _selectedHighlight = null;
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
                  color: col.withValues(alpha: 0.4),
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
            if (_selectedHighlight != null)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _selectedHighlight!.route,
                    color: const Color(0xFF114B5F),
                    strokeWidth: 5,
                    borderColor: Colors.white.withValues(alpha: 0.85),
                    borderStrokeWidth: 2,
                  ),
                ],
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
            if (_selectedHighlight != null)
              MarkerLayer(
                markers: _selectedHighlight!.stops
                    .map(
                      (stop) => Marker(
                        point: stop.location,
                        width: 40,
                        height: 40,
                        child: _AdventureStopMarker(stop: stop),
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
        Positioned(
          top: 16,
          left: 16,
          child: ExploreHighlightsPanel(
            highlights: _highlights,
            selectedVibe: _selectedVibe,
            selectedEffort: _selectedEffort,
            onVibeSelected: (vibe) {
              setState(() {
                _selectedVibe = vibe;
                if (_selectedHighlight != null &&
                    vibe != ExploreVibe.all &&
                    _selectedHighlight!.vibe != vibe) {
                  _selectedHighlight = null;
                }
              });
            },
            onEffortSelected: (effort) {
              setState(() {
                _selectedEffort = effort;
                if (_selectedHighlight != null &&
                    effort != ExploreEffort.all &&
                    _selectedHighlight!.effort != effort) {
                  _selectedHighlight = null;
                }
              });
            },
            onSelected: (highlight) {
              _mapController.move(highlight.center, highlight.zoom);
              setState(() {
                _selectedMuni = null;
                _popupOffset = null;
                _selectedHighlight = highlight;
                _selectedVibe = highlight.vibe;
                _selectedEffort = highlight.effort;
              });
            },
          ),
        ),
        if (_selectedHighlight != null)
          Positioned(
            top: 16,
            right: 16,
            child: AdventurePreviewPanel(
              highlight: _selectedHighlight!,
              onClose: () {
                setState(() {
                  _selectedHighlight = null;
                });
              },
            ),
          ),
        const Positioned(bottom: 40, right: 16, child: OverallProgressWidget()),
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

class _AdventureStopMarker extends StatelessWidget {
  final ExploreStop stop;

  const _AdventureStopMarker({required this.stop});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: stop.markerColor,
          shape: BoxShape.circle,
        ),
        child: Icon(stop.icon, color: Colors.white, size: 18),
      ),
    );
  }
}
