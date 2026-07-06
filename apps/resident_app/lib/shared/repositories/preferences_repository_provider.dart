import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences_repository.dart';
import 'shared_preferences_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw StateError('SharedPreferences must be initialized in main().'),
);

final preferencesRepositoryProvider = Provider<PreferencesRepository>(
  (ref) => SharedPreferencesRepository(ref.watch(sharedPreferencesProvider)),
);
