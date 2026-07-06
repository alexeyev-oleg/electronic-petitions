import 'app/bootstrap.dart';
import 'app/environment/app_environment.dart';

Future<void> main() {
  return runInspectorApp(
    environment: const AppEnvironment(
      flavor: AppFlavor.mock,
      displayName: 'MOCK',
      apiBaseUrl: 'http://localhost.mock',
      usesMockApi: true,
    ),
  );
}
