import 'app/bootstrap.dart';
import 'app/environment/app_environment.dart';

Future<void> main() {
  return runResidentApp(
    environment: const AppEnvironment(
      flavor: AppFlavor.dev,
      displayName: 'DEV',
      apiBaseUrl: 'https://dev-api.example.com',
      usesMockApi: true,
    ),
  );
}
