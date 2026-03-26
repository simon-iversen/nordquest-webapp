import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/auth/logic/auth_providers.dart';
import 'package:nordquest_webapp/src/features/profile/logic/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(currentUserProvider)?.email ?? '';
    final stats = ref.watch(profileStatsProvider);

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
                Icon(Icons.person, color: Colors.white, size: 28),
                SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Text(
                  'Profil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTypography.title,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Text(
                  '· Your Profile',
                  style: TextStyle(
                    color: Color(0xFFB7DEC8),
                    fontSize: AppTypography.md,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _IdentityCard(email: email),
                      const SizedBox(height: AppSpacing.md),
                      _StatsCard(stats: stats),
                      const SizedBox(height: AppSpacing.md),
                      const _StravaCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final Widget child;

  const _ProfileCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(AppSpacing.md + 4),
      child: child,
    );
  }
}

class _IdentityCard extends StatelessWidget {
  final String email;

  const _IdentityCard({required this.email});

  String get _initials =>
      email.isEmpty ? '?' : email[0].toUpperCase();

  @override
  Widget build(BuildContext context) {
    return _ProfileCard(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0xFF2D6A4F),
            child: Text(
              _initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppTypography.xxl,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm + AppSpacing.xs),
          Text(
            email,
            style: const TextStyle(
              fontSize: AppTypography.md,
              color: Color(0xFF1B4332),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final stats;

  const _StatsCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return _ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stats',
            style: TextStyle(
              fontSize: AppTypography.md,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.location_city,
                  label: 'Municipalities visited',
                  value: '${stats.municipalitiesVisited}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
              Expanded(
                child: _StatTile(
                  icon: Icons.route,
                  label: 'Trail km matched',
                  value: '${stats.trailKm} km',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.cottage_outlined,
                  label: 'Huts checked in',
                  value: '${stats.hutsCheckedIn}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
              Expanded(
                child: _StatTile(
                  icon: Icons.sync,
                  label: 'Activities synced',
                  value: '${stats.activitiesSynced}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm + AppSpacing.xs),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F4),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2D6A4F), size: 22),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppTypography.xl - 4,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppTypography.xs,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

class _StravaCard extends StatelessWidget {
  const _StravaCard();

  @override
  Widget build(BuildContext context) {
    return _ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connected Services',
            style: TextStyle(
              fontSize: AppTypography.md,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(
                Icons.directions_run,
                color: Color(0xFFFC4C02),
                size: 28,
              ),
              const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strava',
                      style: TextStyle(
                        fontSize: AppTypography.sm + 1,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                    Text(
                      'Not connected',
                      style: TextStyle(
                        fontSize: AppTypography.xs + 1,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2D6A4F),
                  side: const BorderSide(color: Color(0xFF2D6A4F)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                child: const Text('Connect Strava'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
