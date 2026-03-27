import 'package:flutter/material.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/map/presentation/widgets/explore_highlights_panel.dart';

class AdventurePreviewPanel extends StatelessWidget {
  final ExploreHighlight highlight;
  final List<ExploreHighlight> allHighlights;
  final ValueChanged<ExploreHighlight> onExploreRelated;
  final VoidCallback onClose;

  const AdventurePreviewPanel({
    super.key,
    required this.highlight,
    required this.allHighlights,
    required this.onExploreRelated,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      constraints: const BoxConstraints(maxHeight: 720),
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
      child: SingleChildScrollView(
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
                _StatChip(
                  icon: highlight.effort.icon,
                  label: highlight.effort.label,
                  accent: highlight.effort.accent,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    highlight.gradient.first.withValues(alpha: 0.14),
                    highlight.gradient.last.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: highlight.gradient.last.withValues(alpha: 0.16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sense of place',
                    style: TextStyle(
                      fontSize: AppTypography.sm,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _PlaceFact(
                        icon: Icons.place_rounded,
                        label: 'Region',
                        value: highlight.regionLabel,
                      ),
                      _PlaceFact(
                        icon: Icons.terrain_rounded,
                        label: 'Terrain',
                        value: highlight.terrainLabel,
                      ),
                      _PlaceFact(
                        icon: Icons.wb_sunny_outlined,
                        label: 'Best in',
                        value: highlight.seasonLabel,
                      ),
                      _PlaceFact(
                        icon: Icons.auto_awesome_rounded,
                        label: 'Feels like',
                        value: highlight.momentLabel,
                      ),
                    ],
                  ),
                ],
              ),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAF8),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: const Color(0xFFDDE7E1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick read',
                    style: TextStyle(
                      fontSize: AppTypography.sm,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: highlight.snapshot
                        .map((fact) => _SnapshotFactChip(fact: fact))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: highlight.effort.accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: highlight.effort.accent.withValues(alpha: 0.22),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: highlight.effort.accent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Icon(
                      highlight.effort.icon,
                      size: 18,
                      color: highlight.effort.accent,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${highlight.effort.label} mock outing',
                          style: const TextStyle(
                            fontSize: AppTypography.sm,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF16332B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _effortGuidance(highlight.effort),
                          style: const TextStyle(
                            fontSize: AppTypography.sm,
                            color: Color(0xFF52606D),
                            height: 1.4,
                          ),
                        ),
                      ],
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
            if (_relatedHighlights.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              _KeepExploringSection(
                currentHighlight: highlight,
                relatedHighlights: _relatedHighlights,
                onSelected: onExploreRelated,
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<ExploreHighlight> get _relatedHighlights {
    final related = allHighlights
        .where((candidate) => candidate != highlight)
        .toList();
    related.sort((a, b) => _relatedScore(b).compareTo(_relatedScore(a)));
    return related.take(2).toList();
  }

  int _relatedScore(ExploreHighlight candidate) {
    var score = 0;
    if (candidate.vibe == highlight.vibe) score += 3;
    if (candidate.effort == highlight.effort) score += 2;
    if (candidate.regionLabel.split(' ').first ==
        highlight.regionLabel.split(' ').first) {
      score += 1;
    }
    return score;
  }

  String _effortGuidance(ExploreEffort effort) {
    switch (effort) {
      case ExploreEffort.all:
        return 'A mix of mock adventure intensities across the map.';
      case ExploreEffort.easy:
        return 'Good for quick inspiration, lower planning friction, and scenic payoff without turning the day into a mission.';
      case ExploreEffort.moderate:
        return 'A balanced mock plan with a bit more movement, enough texture to feel adventurous, and still easy to imagine fitting into a normal trip.';
      case ExploreEffort.bigDay:
        return 'More commitment, more mountain drama, and the kind of mock outing you open when you want the destination to feel like a proper objective.';
    }
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? accent;

  const _StatChip({required this.icon, required this.label, this.accent});

  @override
  Widget build(BuildContext context) {
    final background = accent == null
        ? const Color(0xFFEEF4F0)
        : accent!.withValues(alpha: 0.1);
    final foreground = accent ?? const Color(0xFF1B4332);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 180),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: foreground),
            const SizedBox(width: AppSpacing.xs + 2),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppTypography.xs + 1,
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SnapshotFactChip extends StatelessWidget {
  final ExploreSnapshotFact fact;

  const _SnapshotFactChip({required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFDCE7E0)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(fact.icon, size: 16, color: const Color(0xFF335C4A)),
            const SizedBox(width: AppSpacing.xs + 2),
            Flexible(
              child: Text(
                '${fact.label}: ${fact.value}',
                softWrap: true,
                style: const TextStyle(
                  fontSize: AppTypography.xs + 1,
                  color: Color(0xFF335C4A),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceFact extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PlaceFact({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 132, maxWidth: 154),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.85)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF335C4A)),
          const SizedBox(width: AppSpacing.xs + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppTypography.xs,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7A77),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: AppTypography.xs + 1,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16332B),
                    height: 1.3,
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

class _KeepExploringSection extends StatelessWidget {
  final ExploreHighlight currentHighlight;
  final List<ExploreHighlight> relatedHighlights;
  final ValueChanged<ExploreHighlight> onSelected;

  const _KeepExploringSection({
    required this.currentHighlight,
    required this.relatedHighlights,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF5F1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: const Color(0xFFD7E4DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Keep exploring',
            style: TextStyle(
              fontSize: AppTypography.md,
              fontWeight: FontWeight.w700,
              color: Color(0xFF16332B),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'If ${currentHighlight.title} feels right, these nearby moods are the next natural mock adventures to open.',
            style: const TextStyle(
              fontSize: AppTypography.sm,
              color: Color(0xFF52606D),
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...relatedHighlights.map(
            (related) => Padding(
              padding: EdgeInsets.only(
                bottom: related == relatedHighlights.last ? 0 : AppSpacing.sm,
              ),
              child: _RelatedAdventureCard(
                highlight: related,
                reason: _reasonFor(currentHighlight, related),
                onTap: () => onSelected(related),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _reasonFor(ExploreHighlight current, ExploreHighlight related) {
    if (current.vibe == related.vibe) {
      return 'Same outdoor vibe, different part of Norway';
    }
    if (current.effort == related.effort) {
      return 'Same effort level, new landscape payoff';
    }
    return 'A good next branch from this preview';
  }
}

class _RelatedAdventureCard extends StatelessWidget {
  final ExploreHighlight highlight;
  final String reason;
  final VoidCallback onTap;

  const _RelatedAdventureCard({
    required this.highlight,
    required this.reason,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.sm + 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: const Color(0xFFD9E6DE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: highlight.gradient),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(highlight.icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reason,
                      style: const TextStyle(
                        fontSize: AppTypography.xs + 1,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4E6A5D),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      highlight.title,
                      style: const TextStyle(
                        fontSize: AppTypography.sm,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF16332B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      highlight.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: AppTypography.sm,
                        color: Color(0xFF52606D),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _StatChip(
                          icon: Icons.place_rounded,
                          label: highlight.regionLabel,
                        ),
                        _StatChip(
                          icon: highlight.effort.icon,
                          label: highlight.effort.shortLabel,
                          accent: highlight.effort.accent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: Color(0xFF4E6A5D),
              ),
            ],
          ),
        ),
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
