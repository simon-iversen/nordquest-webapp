import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_radius.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_spacing.dart';
import 'package:nordquest_webapp/src/design_system/foundations/app_typography.dart';
import 'package:nordquest_webapp/src/features/auth/logic/auth_providers.dart';

const _kSidebarBg = Color(0xFF1B4332);
const _kSidebarActive = Color(0xFF2D6A4F);
const _kSidebarFg = Color(0xFFB7DEC8);
const _kSidebarWidth = 220.0;

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class AppSidebar extends ConsumerWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: _kSidebarWidth,
      color: _kSidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md + 4,
              AppSpacing.xl,
              AppSpacing.md + 4,
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                Icon(Icons.terrain, color: Colors.white, size: 28),
                SizedBox(width: AppSpacing.sm + 2),
                Text(
                  'NordQuest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTypography.xl - 4,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: _kSidebarActive, thickness: 1, height: 1),
          const SizedBox(height: AppSpacing.sm),
          const _NavItem(
            icon: Icons.map_outlined,
            activeIcon: Icons.map,
            label: 'Map',
            route: '/map',
          ),
          const _NavItem(
            icon: Icons.bar_chart_outlined,
            activeIcon: Icons.bar_chart,
            label: 'Progress',
            route: '/progress',
          ),
          const _NavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            route: '/profile',
          ),
          const Spacer(),
          const Divider(color: _kSidebarActive, thickness: 1, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: _SidebarButton(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () => ref.read(authNotifierProvider).logout(),
              hoverColor: Colors.red.withAlpha(51),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final isActive = currentPath == route;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      child: Material(
        color: isActive ? _kSidebarActive : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          onTap: () => context.go(route),
          hoverColor: _kSidebarActive.withAlpha(128),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm + AppSpacing.xs,
              vertical: AppSpacing.sm + 2,
            ),
            child: Row(
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  color: isActive ? Colors.white : _kSidebarFg,
                  size: 22,
                ),
                const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : _kSidebarFg,
                    fontSize: AppTypography.sm + 1,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.normal,
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

class _SidebarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color hoverColor;

  const _SidebarButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onTap,
        hoverColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + AppSpacing.xs,
            vertical: AppSpacing.sm + 2,
          ),
          child: Row(
            children: [
              Icon(icon, color: _kSidebarFg, size: 22),
              const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
              Text(
                label,
                style: const TextStyle(
                  color: _kSidebarFg,
                  fontSize: AppTypography.sm + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
