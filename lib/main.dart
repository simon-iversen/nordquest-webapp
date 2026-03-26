import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const NordQuestApp());
}

class NordQuestApp extends StatelessWidget {
  const NordQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NordQuest',
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(65.0, 15.0),
          initialZoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'no.nordquest.webapp',
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
    );
  }
}
