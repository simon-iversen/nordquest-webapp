import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/progress/logic/progress_providers.dart';
import 'package:nordquest_webapp/src/features/progress/presentation/widgets/municipality_card.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(municipalityProgressProvider);

    return Container(
      color: const Color(0xFFF1F8F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color(0xFF1B4332),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg + 4,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            child: const Row(
              children: [
                Icon(Icons.bar_chart, color: Colors.white, size: 28),
                SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Text(
                  'Fremgang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTypography.title,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Text(
                  '· Your Progress',
                  style: TextStyle(
                    color: Color(0xFFB7DEC8),
                    fontSize: AppTypography.md,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: progress.length,
              itemBuilder: (context, i) =>
                  MunicipalityCard(data: progress[i]),
            ),
          ),
        ],
      ),
    );
  }
}
