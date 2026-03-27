import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/adventure_preview_panel.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/explore_highlights_panel.dart';

void main() {
  const highlight = ExploreHighlight(
    title: 'Mock fjord mission',
    subtitle: 'A fake scenic route for testing.',
    badge: 'Mock route',
    detail: '2 stops',
    duration: 'Half day',
    bestFor: 'Views',
    whyItWorks: 'Makes exploring feel easier to imagine.',
    regionLabel: 'Mock fjord region',
    terrainLabel: 'Fjord ridge',
    seasonLabel: 'Late summer',
    momentLabel: 'Golden-hour coastal drama',
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

  const related = ExploreHighlight(
    title: 'Cabin branch north',
    subtitle: 'A second fake route to continue exploring.',
    badge: 'Hut trip',
    detail: '3 stops',
    duration: 'Weekend',
    bestFor: 'Cabins',
    whyItWorks: 'Extends the mock discovery flow.',
    regionLabel: 'Northern fjord region',
    terrainLabel: 'Cabin corridor',
    seasonLabel: 'Autumn',
    momentLabel: 'Calm mountain evening',
    icon: Icons.cottage_rounded,
    center: LatLng(62.0, 8.0),
    zoom: 8,
    gradient: [Color(0xFF5B7C3F), Color(0xFF8AB17D)],
    route: [LatLng(62.0, 8.0), LatLng(62.1, 8.1)],
    stops: [
      ExploreStop(
        title: 'Cabin start',
        note: 'Begin here too.',
        icon: Icons.flag_rounded,
        markerColor: Color(0xFF8D6E63),
        location: LatLng(62.0, 8.0),
      ),
    ],
    snapshot: [
      ExploreSnapshotFact(
        label: 'Mood',
        value: 'Quiet',
        icon: Icons.nights_stay_rounded,
      ),
    ],
    vibe: ExploreVibe.cabins,
    effort: ExploreEffort.moderate,
  );

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Future<void> pumpPanel(
    WidgetTester tester, {
    void Function(ExploreHighlight)? onExploreRelated,
  }) async {
    tester.view.physicalSize = const Size(1600, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: AdventurePreviewPanel(
              highlight: highlight,
              allHighlights: const [highlight, related],
              onExploreRelated: onExploreRelated ?? (_) {},
              onClose: () {},
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('shows quick-read snapshot facts for a mock adventure', (
    tester,
  ) async {
    await pumpPanel(tester);

    expect(find.text('Sense of place'), findsOneWidget);
    expect(find.text('Mock fjord region'), findsOneWidget);
    expect(find.text('Late summer'), findsOneWidget);
    expect(find.text('Quick read'), findsOneWidget);
    expect(find.text('Terrain: Fjord ridge'), findsOneWidget);
    expect(find.text('Light: Evening glow'), findsOneWidget);
  });

  testWidgets(
    'shows keep exploring recommendations and opens related preview',
    (tester) async {
      ExploreHighlight? selected;

      await pumpPanel(tester, onExploreRelated: (value) => selected = value);

      expect(find.text('Keep exploring'), findsOneWidget);
      expect(find.text('Cabin branch north'), findsOneWidget);
      expect(
        find.text('Same effort level, new landscape payoff'),
        findsOneWidget,
      );

      await tester.ensureVisible(find.text('Cabin branch north'));
      await tester.tap(find.text('Cabin branch north'));
      await tester.pump();

      expect(selected, related);
    },
  );
}
