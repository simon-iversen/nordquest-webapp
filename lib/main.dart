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
  String _email = '';

  bool get isLoggedIn => _isLoggedIn;
  String get email => _email;

  void login(String email) {
    _isLoggedIn = true;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _email = '';
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
          builder: (_, __) => const ProgressView(),
        ),
        GoRoute(
          path: '/profile',
          builder: (_, __) => const ProfileView(),
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
// Progress screen
// ---------------------------------------------------------------------------

class _MunicipalityProgress {
  final String name;
  final int hikingPct;
  final int skiPct;
  final int hutsVisited;
  final int hutsTotal;

  const _MunicipalityProgress({
    required this.name,
    required this.hikingPct,
    required this.skiPct,
    required this.hutsVisited,
    required this.hutsTotal,
  });
}

const _fakeData = [
  _MunicipalityProgress(
    name: 'Oslo',
    hikingPct: 34,
    skiPct: 12,
    hutsVisited: 2,
    hutsTotal: 8,
  ),
  _MunicipalityProgress(
    name: 'Bergen',
    hikingPct: 51,
    skiPct: 5,
    hutsVisited: 4,
    hutsTotal: 11,
  ),
  _MunicipalityProgress(
    name: 'Tromsø',
    hikingPct: 18,
    skiPct: 42,
    hutsVisited: 1,
    hutsTotal: 6,
  ),
  _MunicipalityProgress(
    name: 'Trondheim',
    hikingPct: 27,
    skiPct: 31,
    hutsVisited: 3,
    hutsTotal: 9,
  ),
  _MunicipalityProgress(
    name: 'Lillehammer',
    hikingPct: 63,
    skiPct: 78,
    hutsVisited: 5,
    hutsTotal: 7,
  ),
  _MunicipalityProgress(
    name: 'Ullensaker',
    hikingPct: 9,
    skiPct: 22,
    hutsVisited: 0,
    hutsTotal: 3,
  ),
];

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F8F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            color: const Color(0xFF1B4332),
            padding: const EdgeInsets.fromLTRB(32, 28, 32, 24),
            child: const Row(
              children: [
                Icon(Icons.bar_chart, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  'Fremgang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '· Your Progress',
                  style: TextStyle(
                    color: Color(0xFFB7DEC8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _fakeData.length,
              itemBuilder: (context, i) =>
                  _MunicipalityCard(data: _fakeData[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MunicipalityCard extends StatelessWidget {
  final _MunicipalityProgress data;
  const _MunicipalityCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      constraints: const BoxConstraints(maxWidth: 720),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Municipality name
            Text(
              data.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: 14),
            _CategoryRow(
              icon: Icons.hiking,
              label: 'Hiking trails',
              value: '${data.hikingPct}%',
              fraction: data.hikingPct / 100,
              color: const Color(0xFF2D6A4F),
            ),
            const SizedBox(height: 10),
            _CategoryRow(
              icon: Icons.downhill_skiing,
              label: 'Ski trails',
              value: '${data.skiPct}%',
              fraction: data.skiPct / 100,
              color: const Color(0xFF52B788),
            ),
            const SizedBox(height: 10),
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
        const SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 8,
              backgroundColor: const Color(0xFFE8F5EE),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 42,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Profile screen
// ---------------------------------------------------------------------------

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  String _initials(String email) {
    if (email.isEmpty) return '?';
    return email[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(authProvider).email;

    return Container(
      color: const Color(0xFFF1F8F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            color: const Color(0xFF1B4332),
            padding: const EdgeInsets.fromLTRB(32, 28, 32, 24),
            child: const Row(
              children: [
                Icon(Icons.person, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  'Profil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '· Your Profile',
                  style: TextStyle(
                    color: Color(0xFFB7DEC8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Avatar + email card
                      _ProfileCard(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xFF2D6A4F),
                              child: Text(
                                _initials(email),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF1B4332),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Stats card
                      _ProfileCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Stats',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _StatTile(
                                    icon: Icons.location_city,
                                    label: 'Municipalities visited',
                                    value: '6',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatTile(
                                    icon: Icons.route,
                                    label: 'Trail km matched',
                                    value: '142 km',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _StatTile(
                                    icon: Icons.cottage_outlined,
                                    label: 'Huts checked in',
                                    value: '3',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatTile(
                                    icon: Icons.sync,
                                    label: 'Activities synced',
                                    value: '47',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Connected services card
                      _ProfileCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Connected Services',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(
                                  Icons.directions_run,
                                  color: Color(0xFFFC4C02),
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Strava',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1B4332),
                                        ),
                                      ),
                                      Text(
                                        'Not connected',
                                        style: TextStyle(
                                          fontSize: 13,
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
                                    side: const BorderSide(
                                        color: Color(0xFF2D6A4F)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)),
                                  ),
                                  child: const Text('Connect Strava'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2D6A4F), size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
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
      ref.read(authProvider).login(_emailController.text.trim());
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
