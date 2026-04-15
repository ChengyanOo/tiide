import 'package:go_router/go_router.dart';

import '../features/dashboard/cluster_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/home/home_screen.dart';
import '../features/session/active_screen.dart';
import '../features/session/list_screen.dart';
import '../features/session/session_detail_screen.dart';
import '../features/settings/permission_explainer_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/active', builder: (_, _) => const ActiveScreen()),
    GoRoute(path: '/sessions', builder: (_, _) => const SessionListScreen()),
    GoRoute(
      path: '/sessions/:id',
      builder: (_, state) => SessionDetailScreen(
        sessionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/permissions',
      builder: (_, _) => const PermissionExplainerScreen(),
    ),
    GoRoute(path: '/dashboard', builder: (_, _) => const DashboardScreen()),
    GoRoute(path: '/clusters', builder: (_, _) => const ClusterScreen()),
  ],
);
