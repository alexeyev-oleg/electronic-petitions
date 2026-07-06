import 'app/bootstrap.dart';
import 'app/environment/app_environment.dart';

Future<void> main() {
  return runResidentApp(
    environment: const AppEnvironment(
      flavor: AppFlavor.prod,
      displayName: 'PROD',
      apiBaseUrl: 'https://api.example.com',
      usesMockApi: false,
    ),
  );
}
