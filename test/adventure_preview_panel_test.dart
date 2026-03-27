import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/adventure_preview_panel.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/explore_highlights_panel.dart';

void main() {
  testWidgets('shows quick-read snapshot facts for a mock adventure', (
    tester,
  ) async {
    const highlight = ExploreHighlight(
      title: 'Mock fjord mission',
      subtitle: 'A fake scenic route for testing.',
      badge: 'Mock route',
      detail: '2 stops',
      duration: 'Half day',
      bestFor: 'Views',
      whyItWorks: 'Makes exploring feel easier to imagine.',
      icon: Icons.landscape_rounded,
      center: LatLng(61.0, 7.0),
      zoom: 8,
      gradient: [Color(0xFF214E57), Color(0xFF3F7D6A)],
      route: [LatLng(61.0, 7.0), LatLng(61.1, 7.1)],
      stops: [
        ExploreStop(
          title: 'Start',
          note: 'Begin here.',
          icon: Icons.flag_rounded,
          markerColor: Color(0xFF2D6A4F),
          location: LatLng(61.0, 7.0),
        ),
      ],
      snapshot: [
        ExploreSnapshotFact(
          label: 'Terrain',
          value: 'Fjord ridge',
          icon: Icons.terrain_rounded,
        ),
        ExploreSnapshotFact(
          label: 'Light',
          value: 'Evening glow',
          icon: Icons.wb_twilight_rounded,
        ),
      ],
      vibe: ExploreVibe.ridges,
      effort: ExploreEffort.moderate,
    );

    tester.view.physicalSize = const Size(1600, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: AdventurePreviewPanel(highlight: highlight, onClose: () {}),
          ),
        ),
      ),
    );

    expect(find.text('Quick read'), findsOneWidget);
    expect(find.text('Terrain: Fjord ridge'), findsOneWidget);
    expect(find.text('Light: Evening glow'), findsOneWidget);
  });
}
