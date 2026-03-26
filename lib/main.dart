import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

// ---------------------------------------------------------------------------
// Auth state
// ---------------------------------------------------------------------------

class AuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

final _authNotifier = AuthNotifier();

final authProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => _authNotifier);

// ---------------------------------------------------------------------------
// Router
// ---------------------------------------------------------------------------

final _router = GoRouter(
  refreshListenable: _authNotifier,
  initialLocation: '/map',
  redirect: (context, state) {
    final loggedIn = _authNotifier.isLoggedIn;
    final onLogin = state.matchedLocation == '/login';
    if (!loggedIn && !onLogin) return '/login';
    if (loggedIn && onLogin) return '/map';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/map', builder: (_, __) => const MapView()),
        GoRoute(
          path: '/progress',
          builder: (_, __) => const _PlaceholderView(label: 'Progress'),
        ),
        GoRoute(
          path: '/profile',
          builder: (_, __) => const _PlaceholderView(label: 'Profile'),
        ),
      ],
    ),
  ],
);

// ---------------------------------------------------------------------------
// App root
// ---------------------------------------------------------------------------

void main() {
  runApp(const ProviderScope(child: NordQuestApp()));
}

class NordQuestApp extends StatelessWidget {
  const NordQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NordQuest',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2D6A4F),
        useMaterial3: true,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App shell
// ---------------------------------------------------------------------------

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const _Sidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sidebar
// ---------------------------------------------------------------------------

const _kSidebarBg = Color(0xFF1B4332);
const _kSidebarActive = Color(0xFF2D6A4F);
const _kSidebarFg = Color(0xFFB7DEC8);
const _kSidebarWidth = 220.0;

class _Sidebar extends ConsumerWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: _kSidebarWidth,
      color: _kSidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 32, 20, 24),
            child: Row(
              children: [
                Icon(Icons.terrain, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'NordQuest',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: _kSidebarActive, thickness: 1, height: 1),
          const SizedBox(height: 8),
          // Nav items
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
          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: _SidebarButton(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () => ref.read(authProvider).logout(),
              hoverColor: Colors.red.withAlpha(51),
            ),
          ),
          const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: isActive ? _kSidebarActive : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.go(route),
          hoverColor: _kSidebarActive.withAlpha(128),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  color: isActive ? Colors.white : _kSidebarFg,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : _kSidebarFg,
                    fontSize: 15,
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
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        hoverColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: _kSidebarFg, size: 22),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(color: _kSidebarFg, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Map view
// ---------------------------------------------------------------------------

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(65.0, 15.0),
        initialZoom: 5.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'no.nordquest.webapp',
        ),
        const RichAttributionWidget(
          alignment: AttributionAlignment.bottomRight,
          showFlutterMapAttribution: false,
          attributions: [
            TextSourceAttribution('© OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Placeholder screens
// ---------------------------------------------------------------------------

class _PlaceholderView extends StatelessWidget {
  final String label;
  const _PlaceholderView({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming soon',
            style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Login screen
// ---------------------------------------------------------------------------

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ref.read(authProvider).login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8F4),
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.terrain,
                size: 56,
                color: Color(0xFF2D6A4F),
              ),
              const SizedBox(height: 12),
              const Text(
                'NordQuest',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Explore Norway's wilderness",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
