import 'package:flutter/material.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/progress/domain/municipality_progress.dart';

class MunicipalityCard extends StatelessWidget {
  final MunicipalityProgress data;

  const MunicipalityCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      constraints: const BoxConstraints(maxWidth: 720),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: AppSpacing.sm,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.name,
              style: const TextStyle(
                fontSize: AppTypography.lg,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: AppSpacing.md - 2),
            _CategoryRow(
              icon: Icons.hiking,
              label: 'Hiking trails',
              value: '${data.hikingPercent}%',
              fraction: data.hikingPercent / 100,
              color: const Color(0xFF2D6A4F),
            ),
            const SizedBox(height: AppSpacing.sm + 2),
            _CategoryRow(
              icon: Icons.downhill_skiing,
              label: 'Ski trails',
              value: '${data.skiPercent}%',
              fraction: data.skiPercent / 100,
              color: const Color(0xFF52B788),
            ),
            const SizedBox(height: AppSpacing.sm + 2),
            _CategoryRow(
              icon: Icons.cottage_outlined,
              label: 'Huts',
              value: '${data.hutsVisited}/${data.hutsTotal}',
              fraction: data.hutsTotal == 0
                  ? 0
                  : data.hutsVisited / data.hutsTotal,
              color: const Color(0xFF95D5B2),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double fraction;
  final Color color;

  const _CategoryRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.fraction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF2D6A4F)),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: AppTypography.xs + 1,
              color: Color(0xFF374151),
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: AppSpacing.sm,
              backgroundColor: const Color(0xFFE8F5EE),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm + 2),
        SizedBox(
          width: 42,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: AppTypography.xs + 1,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
