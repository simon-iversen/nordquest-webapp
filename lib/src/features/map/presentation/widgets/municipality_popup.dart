import 'package:flutter/material.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/map/domain/municipality.dart';

Color municipalityColor(int pct) {
  if (pct == 0) return const Color(0xFFE0E0E0);
  if (pct <= 30) return const Color(0xFF95D5B2);
  if (pct <= 70) return const Color(0xFF52B788);
  if (pct < 100) return const Color(0xFF2D6A4F);
  return const Color(0xFF1B4332);
}

class MunicipalityPopup extends StatelessWidget {
  final Municipality municipality;

  const MunicipalityPopup({super.key, required this.municipality});

  @override
  Widget build(BuildContext context) {
    final color = municipalityColor(municipality.completionPercent);
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(AppRadius.button),
      shadowColor: Colors.black26,
      child: Container(
        width: 215,
        padding: const EdgeInsets.all(AppSpacing.md - 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _PopupHeader(municipality: municipality, color: color),
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),
            _PopupRow(
              icon: Icons.hiking,
              label: 'Hiking trails',
              value: '${municipality.hikingPercent}%',
            ),
            const SizedBox(height: AppSpacing.sm - 2),
            _PopupRow(
              icon: Icons.downhill_skiing,
              label: 'Ski trails',
              value: '${municipality.skiPercent}%',
            ),
            const SizedBox(height: AppSpacing.sm - 2),
            _PopupRow(
              icon: Icons.cottage_outlined,
              label: 'Huts',
              value:
                  '${municipality.hutsVisited}/${municipality.hutsTotal} visited',
            ),
          ],
        ),
      ),
    );
  }
}

class _PopupHeader extends StatelessWidget {
  final Municipality municipality;
  final Color color;

  const _PopupHeader({required this.municipality, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            municipality.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppTypography.sm + 1,
              color: Color(0xFF1B4332),
            ),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          '${municipality.completionPercent}%',
          style: TextStyle(
            fontSize: AppTypography.xs + 1,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _PopupRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PopupRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF52B788)),
        const SizedBox(width: AppSpacing.sm - 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppTypography.xs,
            color: Color(0xFF6B7280),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppTypography.xs,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }
}
