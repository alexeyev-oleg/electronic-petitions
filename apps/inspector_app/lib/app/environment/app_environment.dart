import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppFlavor {
  mock,
  dev,
  staging,
  prod,
}

class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.displayName,
    required this.apiBaseUrl,
    required this.usesMockApi,
  });

  final AppFlavor flavor;
  final String displayName;
  final String apiBaseUrl;
  final bool usesMockApi;

  bool get isBetaLike => flavor == AppFlavor.mock || flavor == AppFlavor.dev;
}

final appEnvironmentProvider = Provider<AppEnvironment>(
  (_) => const AppEnvironment(
    flavor: AppFlavor.mock,
    displayName: 'Mock',
    apiBaseUrl: 'http://localhost.mock',
    usesMockApi: true,
  ),
);
