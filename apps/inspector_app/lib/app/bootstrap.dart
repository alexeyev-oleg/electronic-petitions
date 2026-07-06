import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'environment/app_environment.dart';
import '../shared/providers/shared_preferences_provider.dart';

Future<void> runInspectorApp({
  required AppEnvironment environment,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        appEnvironmentProvider.overrideWithValue(environment),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: const InspectorApp(),
    ),
  );
}
