import 'app/bootstrap.dart';
import 'app/environment/app_environment.dart';

Future<void> main() {
  return runResidentApp(
    environment: const AppEnvironment(
      flavor: AppFlavor.mock,
      displayName: 'MOCK',
      apiBaseUrl: 'http://localhost.mock',
      usesMockApi: true,
      enableAnalytics: true,
      enableCrashReporting: true,
      enablePushScaffold: true,
    ),
  );
}
