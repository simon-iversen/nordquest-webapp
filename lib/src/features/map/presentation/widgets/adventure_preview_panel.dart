import 'package:flutter/material.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/explore_highlights_panel.dart';

class AdventurePreviewPanel extends StatelessWidget {
  final ExploreHighlight highlight;
  final VoidCallback onClose;

  const AdventurePreviewPanel({
    super.key,
    required this.highlight,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(AppRadius.sheet),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: highlight.gradient),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        highlight.badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppTypography.xs,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      highlight.title,
                      style: const TextStyle(
                        fontSize: AppTypography.xl - 2,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF16332B),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      highlight.subtitle,
                      style: const TextStyle(
                        fontSize: AppTypography.sm,
                        color: Color(0xFF52606D),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: onClose,
                tooltip: 'Close preview',
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _StatChip(icon: Icons.route_rounded, label: highlight.detail),
              _StatChip(
                icon: Icons.schedule_rounded,
                label: highlight.duration,
              ),
              _StatChip(icon: Icons.park_rounded, label: highlight.bestFor),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F8F6),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: const Color(0xFFDDE7E1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Why this feels worth opening',
                  style: TextStyle(
                    fontSize: AppTypography.sm,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B4332),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  highlight.whyItWorks,
                  style: const TextStyle(
                    fontSize: AppTypography.sm,
                    color: Color(0xFF52606D),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Mock route flow',
            style: TextStyle(
              fontSize: AppTypography.md,
              fontWeight: FontWeight.w700,
              color: Color(0xFF16332B),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...highlight.stops.asMap().entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(
                bottom: entry.key == highlight.stops.length - 1
                    ? 0
                    : AppSpacing.sm,
              ),
              child: _StopTile(
                stop: entry.value,
                isLast: entry.key == highlight.stops.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4F0),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF1B4332)),
          const SizedBox(width: AppSpacing.xs + 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppTypography.xs + 1,
              color: Color(0xFF24453A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StopTile extends StatelessWidget {
  final ExploreStop stop;
  final bool isLast;

  const _StopTile({required this.stop, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: stop.markerColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Icon(stop.icon, size: 16, color: Colors.white),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 34,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                color: const Color(0xFFD6E1DB),
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.sm + 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stop.title,
                  style: const TextStyle(
                    fontSize: AppTypography.sm,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16332B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stop.note,
                  style: const TextStyle(
                    fontSize: AppTypography.sm,
                    color: Color(0xFF52606D),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
