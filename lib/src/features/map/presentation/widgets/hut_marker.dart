import 'package:flutter/material.dart';

class HutMarker extends StatelessWidget {
  final bool visited;

  const HutMarker({super.key, required this.visited});

  @override
  Widget build(BuildContext context) {
    if (visited) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2D6A4F),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.cottage, color: Colors.white, size: 14),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF9E9E9E), width: 2),
      ),
      child: const Icon(
        Icons.cottage_outlined,
        color: Color(0xFF9E9E9E),
        size: 12,
      ),
    );
  }
}
