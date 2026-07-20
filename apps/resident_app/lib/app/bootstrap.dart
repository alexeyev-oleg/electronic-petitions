import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/monitoring/app_monitoring.dart';
import 'app.dart';
import 'environment/app_environment.dart';
import '../core/services/push_notification_service.dart';
import '../features/profile/application/preferences_controller.dart';
import '../shared/repositories/preferences_repository_provider.dart';

Future<void> runResidentApp({
  required AppEnvironment environment,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppMonitoring.initialize(environment);
  final preferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        appEnvironmentProvider.overrideWithValue(environment),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: const AppServiceBootstrap(),
    ),
  );
}

class AppServiceBootstrap extends ConsumerStatefulWidget {
  const AppServiceBootstrap({super.key});

  @override
  ConsumerState<AppServiceBootstrap> createState() =>
      _AppServiceBootstrapState();
}

class _AppServiceBootstrapState extends ConsumerState<AppServiceBootstrap> {
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    final environment = ref.read(appEnvironmentProvider);
    if (!environment.enablePushScaffold) {
      return;
    }

    try {
      final push = ref.read(pushNotificationServiceProvider);
      await push.initialize();
      final preferences = ref.read(preferencesControllerProvider);
      await preferences.ensureInitialized();
      await push.setEnabled(preferences.notificationPreferences.pushEnabled);
    } catch (error, stackTrace) {
      await AppMonitoring.recordError(error, stackTrace, reason: 'push_init');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const ResidentApp();
  }
}
