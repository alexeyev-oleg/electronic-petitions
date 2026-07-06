import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/triage/presentation/screens/triage_queue_screen.dart';
import '../../features/triage/presentation/screens/triage_report_detail_screen.dart';

final appRouterProvider = Provider<GoRouter>(
  (_) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/triage',
        builder: (context, state) => const TriageQueueScreen(),
      ),
      GoRoute(
        path: '/triage/:reportId',
        builder: (context, state) => TriageReportDetailScreen(
          reportId: state.pathParameters['reportId']!,
        ),
      ),
    ],
  ),
);
