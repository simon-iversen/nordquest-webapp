import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';

class ExploreHighlight {
  final String title;
  final String subtitle;
  final String badge;
  final String detail;
  final IconData icon;
  final LatLng center;
  final double zoom;
  final List<Color> gradient;

  const ExploreHighlight({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.detail,
    required this.icon,
    required this.center,
    required this.zoom,
    required this.gradient,
  });
}

class ExploreHighlightsPanel extends StatelessWidget {
  final List<ExploreHighlight> highlights;
  final ValueChanged<ExploreHighlight> onSelected;

  const ExploreHighlightsPanel({
    super.key,
    required this.highlights,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Explore Norway',
            style: TextStyle(
              fontSize: AppTypography.lg,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B4332),
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'A few mock adventures to help the map feel discoverable, not just readable.',
            style: TextStyle(
              fontSize: AppTypography.sm,
              height: 1.4,
              color: Color(0xFF52606D),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...highlights.map(
            (highlight) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _HighlightCard(
                highlight: highlight,
                onTap: () => onSelected(highlight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final ExploreHighlight highlight;
  final VoidCallback onTap;

  const _HighlightCard({required this.highlight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: highlight.gradient,
            ),
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Icon(highlight.icon, color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        highlight.badge,
                        style: const TextStyle(
                          fontSize: AppTypography.xs,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  highlight.title,
                  style: const TextStyle(
                    fontSize: AppTypography.md,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  highlight.subtitle,
                  style: const TextStyle(
                    fontSize: AppTypography.sm,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  highlight.detail,
                  style: TextStyle(
                    fontSize: AppTypography.xs + 1,
                    color: Colors.white.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
