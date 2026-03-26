import 'package:flutter/material.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';

class OverallProgressWidget extends StatelessWidget {
  const OverallProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: AppSpacing.sm + AppSpacing.xs,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md - 2,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: CircularProgressIndicator(
              value: 0.042,
              backgroundColor: const Color(0xFFE8F5EE),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2D6A4F),
              ),
              strokeWidth: 4.5,
            ),
          ),
          const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Norway explored',
                style: TextStyle(
                  fontSize: AppTypography.xs - 2,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '4.2%',
                style: TextStyle(
                  fontSize: AppTypography.lg,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
