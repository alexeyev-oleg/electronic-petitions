import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/triage/application/triage_report.dart';
import '../../shared/providers/shared_preferences_provider.dart';
import 'mock_seed_data.dart';
import 'shared_seed_bridge.dart';

final mockLocalStoreProvider = Provider<MockLocalStore>(
  (ref) => MockLocalStore(ref.watch(sharedPreferencesProvider)),
);

class MockLocalStore {
  MockLocalStore(this._preferences);

  final SharedPreferences _preferences;
  static const _triageKey = 'mock_inspector_triage_v1';
  static const _sharedSeedVersionKey = 'gesher_mock_seed_version';

  Future<void> _syncSharedSeedIfNeeded() async {
    try {
      final assetVersion = await SharedSeedBridge.seedVersion();
      final storedVersion = _preferences.getString(_sharedSeedVersionKey);
      if (storedVersion == assetVersion) {
        return;
      }

      final root = await SharedSeedBridge.loadRoot();
      await saveTriageReports(SharedSeedBridge.toTriageReports(root));
      await _preferences.setString(_sharedSeedVersionKey, assetVersion);
    } catch (_) {
      // Keep legacy seeds when asset bundle is unavailable (tests).
    }
  }

  Future<List<TriageReport>> readTriageReports() async {
    await _syncSharedSeedIfNeeded();
    final raw = _preferences.getString(_triageKey);
    if (raw == null) {
      final seed = MockSeedData.triageReports();
      await saveTriageReports(seed);
      return seed;
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => TriageReport.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTriageReports(List<TriageReport> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await _preferences.setString(_triageKey, encoded);
  }
}
