import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';

enum ExploreVibe {
  all(
    label: 'All',
    description: 'See a mix of mock adventures across Norway.',
    icon: Icons.explore_rounded,
  ),
  ridges(
    label: 'Ridges',
    description: 'Sharp lines, summit feeling, and dramatic terrain.',
    icon: Icons.landscape_rounded,
  ),
  cabins(
    label: 'Cabins',
    description: 'Cozy hut-to-hut ideas with calmer pacing.',
    icon: Icons.cabin_rounded,
  ),
  coast(
    label: 'Coast',
    description: 'Sea cliffs, beaches, and high-payoff views.',
    icon: Icons.waves_rounded,
  );

  const ExploreVibe({
    required this.label,
    required this.description,
    required this.icon,
  });

  final String label;
  final String description;
  final IconData icon;
}

enum ExploreEffort {
  all(
    label: 'All efforts',
    shortLabel: 'All',
    description: 'Mix easy wins with bigger mock mountain days.',
    icon: Icons.tune_rounded,
    accent: Color(0xFF335C4A),
  ),
  easy(
    label: 'Easy start',
    shortLabel: 'Easy',
    description: 'Short, scenic mock adventures with low friction.',
    icon: Icons.spa_rounded,
    accent: Color(0xFF4F772D),
  ),
  moderate(
    label: 'Moderate',
    shortLabel: 'Moderate',
    description: 'Balanced mock days with a bit more movement and payoff.',
    icon: Icons.hiking_rounded,
    accent: Color(0xFF2A6F97),
  ),
  bigDay(
    label: 'Big day',
    shortLabel: 'Big day',
    description: 'Bigger mock outings with more commitment and drama.',
    icon: Icons.terrain_rounded,
    accent: Color(0xFF9C6644),
  );

  const ExploreEffort({
    required this.label,
    required this.shortLabel,
    required this.description,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String shortLabel;
  final String description;
  final IconData icon;
  final Color accent;
}

class ExploreHighlight {
  final String title;
  final String subtitle;
  final String badge;
  final String detail;
  final String duration;
  final String bestFor;
  final String whyItWorks;
  final IconData icon;
  final LatLng center;
  final double zoom;
  final List<Color> gradient;
  final List<LatLng> route;
  final List<ExploreStop> stops;
  final List<ExploreSnapshotFact> snapshot;
  final ExploreVibe vibe;
  final ExploreEffort effort;

  const ExploreHighlight({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.detail,
    required this.duration,
    required this.bestFor,
    required this.whyItWorks,
    required this.icon,
    required this.center,
    required this.zoom,
    required this.gradient,
    required this.route,
    required this.stops,
    required this.snapshot,
    required this.vibe,
    required this.effort,
  });
}

class ExploreSnapshotFact {
  final String label;
  final String value;
  final IconData icon;

  const ExploreSnapshotFact({
    required this.label,
    required this.value,
    required this.icon,
  });
}

class ExploreStop {
  final String title;
  final String note;
  final IconData icon;
  final Color markerColor;
  final LatLng location;

  const ExploreStop({
    required this.title,
    required this.note,
    required this.icon,
    required this.markerColor,
    required this.location,
  });
}

class ExploreHighlightsPanel extends StatelessWidget {
  final List<ExploreHighlight> highlights;
  final ValueChanged<ExploreHighlight> onSelected;
  final ExploreVibe selectedVibe;
  final ValueChanged<ExploreVibe> onVibeSelected;
  final ExploreEffort selectedEffort;
  final ValueChanged<ExploreEffort> onEffortSelected;

  const ExploreHighlightsPanel({
    super.key,
    required this.highlights,
    required this.onSelected,
    required this.selectedVibe,
    required this.onVibeSelected,
    required this.selectedEffort,
    required this.onEffortSelected,
  });

  @override
  Widget build(BuildContext context) {
    final visibleHighlights = highlights.where((highlight) {
      final matchesVibe =
          selectedVibe == ExploreVibe.all || highlight.vibe == selectedVibe;
      final matchesEffort =
          selectedEffort == ExploreEffort.all ||
          highlight.effort == selectedEffort;
      return matchesVibe && matchesEffort;
    }).toList();

    return Container(
      width: 340,
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
            'Start from the kind of outdoor feeling you want, not just a place on the map.',
            style: TextStyle(
              fontSize: AppTypography.sm,
              height: 1.4,
              color: Color(0xFF52606D),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Browse by vibe',
            style: TextStyle(
              fontSize: AppTypography.sm,
              fontWeight: FontWeight.w700,
              color: Color(0xFF24453A),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: ExploreVibe.values
                .map(
                  (vibe) => _VibeChip(
                    vibe: vibe,
                    isSelected: vibe == selectedVibe,
                    onTap: () => onVibeSelected(vibe),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _FilterSummaryCard(
            icon: selectedVibe.icon,
            title: selectedVibe == ExploreVibe.all
                ? 'Open the whole map'
                : '${selectedVibe.label} mode',
            description: selectedVibe.description,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Choose your effort',
            style: TextStyle(
              fontSize: AppTypography.sm,
              fontWeight: FontWeight.w700,
              color: Color(0xFF24453A),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: ExploreEffort.values
                .map(
                  (effort) => _EffortChip(
                    effort: effort,
                    isSelected: effort == selectedEffort,
                    onTap: () => onEffortSelected(effort),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _FilterSummaryCard(
            icon: selectedEffort.icon,
            title: selectedEffort.label,
            description: selectedEffort.description,
            iconBackground: selectedEffort.accent.withValues(alpha: 0.12),
            iconColor: selectedEffort.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          if (visibleHighlights.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9F8),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: const Color(0xFFDDE7E1)),
              ),
              child: const Text(
                'No mock adventures match that combo yet. Try a different vibe or effort level.',
                style: TextStyle(
                  fontSize: AppTypography.sm,
                  color: Color(0xFF52606D),
                  height: 1.4,
                ),
              ),
            )
          else
            ...visibleHighlights.map(
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

class _FilterSummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? iconBackground;
  final Color? iconColor;

  const _FilterSummaryCard({
    required this.icon,
    required this.title,
    required this.description,
    this.iconBackground,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm + 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F5),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: const Color(0xFFDDE7E1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBackground ?? const Color(0xFFE2EFE8),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              icon,
              color: iconColor ?? const Color(0xFF1B4332),
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppTypography.sm,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B4332),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppTypography.xs + 1,
                    color: Color(0xFF52606D),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VibeChip extends StatelessWidget {
  final ExploreVibe vibe;
  final bool isSelected;
  final VoidCallback onTap;

  const _VibeChip({
    required this.vibe,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 2,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF1B4332)
                : const Color(0xFFF4F8F5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF1B4332)
                  : const Color(0xFFD6E5DC),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                vibe.icon,
                size: 16,
                color: isSelected ? Colors.white : const Color(0xFF335C4A),
              ),
              const SizedBox(width: AppSpacing.xs + 2),
              Text(
                vibe.label,
                style: TextStyle(
                  fontSize: AppTypography.xs + 1,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF335C4A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EffortChip extends StatelessWidget {
  final ExploreEffort effort;
  final bool isSelected;
  final VoidCallback onTap;

  const _EffortChip({
    required this.effort,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 2,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? effort.accent : const Color(0xFFF7F9F8),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? effort.accent : const Color(0xFFD6E5DC),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                effort.icon,
                size: 16,
                color: isSelected ? Colors.white : effort.accent,
              ),
              const SizedBox(width: AppSpacing.xs + 2),
              Text(
                effort.shortLabel,
                style: TextStyle(
                  fontSize: AppTypography.xs + 1,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : effort.accent,
                ),
              ),
            ],
          ),
        ),
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
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    _CardMetaChip(label: highlight.detail),
                    _CardMetaChip(label: highlight.effort.label),
                    ...highlight.snapshot
                        .take(2)
                        .map(
                          (fact) => _CardMetaChip(
                            icon: fact.icon,
                            label: '${fact.label}: ${fact.value}',
                          ),
                        ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.travel_explore_rounded,
                      size: 16,
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Preview route',
                      style: TextStyle(
                        fontSize: AppTypography.xs + 1,
                        color: Colors.white.withValues(alpha: 0.92),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardMetaChip extends StatelessWidget {
  final String label;
  final IconData? icon;

  const _CardMetaChip({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: Colors.white.withValues(alpha: 0.92)),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: AppTypography.xs + 1,
              color: Colors.white.withValues(alpha: 0.95),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
