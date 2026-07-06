import 'app/bootstrap.dart';
import 'app/environment/app_environment.dart';

Future<void> main() {
  return runResidentApp(
    environment: const AppEnvironment(
      flavor: AppFlavor.staging,
      displayName: 'STAGING',
      apiBaseUrl: 'https://staging-api.example.com',
      usesMockApi: false,
    ),
  );
}
