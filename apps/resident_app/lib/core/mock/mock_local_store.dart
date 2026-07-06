import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/complaints/application/complaint.dart';
import '../../features/enforcement/application/enforcement_report.dart';
import '../../features/notifications/application/app_notification.dart';
import '../../features/petitions/application/petition.dart';
import '../../shared/repositories/preferences_repository_provider.dart';
import 'mock_load_exception.dart';
import 'mock_seed_data.dart';
import 'shared_seed_bridge.dart';

final mockLocalStoreProvider = Provider<MockLocalStore>(
  (ref) => MockLocalStore(ref.watch(sharedPreferencesProvider)),
);

class MockLocalStore {
  MockLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _complaintsKey = 'mock_complaints_v1';
  static const _enforcementKey = 'mock_enforcement_v2';
  static const _petitionsKey = 'mock_petitions_v2';
  static const _notificationsKey = 'mock_notifications_v1';
  static const _simulateLoadErrorKey = 'mock_simulate_load_error';
  static const _sharedSeedVersionKey = 'gesher_mock_seed_version';

  Future<void> _syncSharedSeedIfNeeded() async {
    try {
      final assetVersion = await SharedSeedBridge.seedVersion();
      final storedVersion = _preferences.getString(_sharedSeedVersionKey);
      if (storedVersion == assetVersion) {
        return;
      }

      final root = await SharedSeedBridge.loadRoot();
      await savePetitions(SharedSeedBridge.toPetitions(root));
      await saveComplaints(SharedSeedBridge.toComplaints(root));
      await saveEnforcementReports(SharedSeedBridge.toEnforcementReports(root));
      await saveNotifications(SharedSeedBridge.toNotifications(root));
      await _preferences.setString(_sharedSeedVersionKey, assetVersion);
    } catch (_) {
      // Keep legacy in-memory seeds when asset bundle is unavailable (tests).
    }
  }

  bool get simulateLoadError =>
      _preferences.getBool(_simulateLoadErrorKey) ?? false;

  Future<void> setSimulateLoadError(bool value) async {
    await _preferences.setBool(_simulateLoadErrorKey, value);
  }

  void _throwIfSimulatedFailure() {
    if (simulateLoadError) {
      throw const MockLoadException();
    }
  }

  Future<List<Complaint>> readComplaints() async {
    await _syncSharedSeedIfNeeded();
    final raw = _preferences.getString(_complaintsKey);
    if (raw == null) {
      final seed = MockSeedData.complaints();
      await saveComplaints(seed);
      return seed;
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Complaint.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Complaint>> fetchComplaints() async {
    _throwIfSimulatedFailure();
    return readComplaints();
  }

  Future<void> saveComplaints(List<Complaint> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await _preferences.setString(_complaintsKey, encoded);
  }

  Future<List<EnforcementReport>> readEnforcementReports() async {
    await _syncSharedSeedIfNeeded();
    final raw = _preferences.getString(_enforcementKey);
    if (raw == null) {
      final seed = MockSeedData.enforcementReports();
      await saveEnforcementReports(seed);
      return seed;
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => EnforcementReport.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<EnforcementReport>> fetchEnforcementReports() async {
    _throwIfSimulatedFailure();
    return readEnforcementReports();
  }

  Future<void> saveEnforcementReports(List<EnforcementReport> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await _preferences.setString(_enforcementKey, encoded);
  }

  Future<List<Petition>> readPetitions() async {
    await _syncSharedSeedIfNeeded();
    final raw = _preferences.getString(_petitionsKey);
    if (raw == null) {
      final seed = MockSeedData.petitions();
      await savePetitions(seed);
      return seed;
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Petition.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Petition>> fetchPetitions() async {
    _throwIfSimulatedFailure();
    return readPetitions();
  }

  Future<void> savePetitions(List<Petition> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await _preferences.setString(_petitionsKey, encoded);
  }

  Future<List<AppNotification>> readNotifications() async {
    final raw = _preferences.getString(_notificationsKey);
    if (raw == null) {
      final seed = MockSeedData.notifications();
      await saveNotifications(seed);
      return seed;
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => AppNotification.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<AppNotification>> fetchNotifications() async {
    _throwIfSimulatedFailure();
    return readNotifications();
  }

  Future<void> saveNotifications(List<AppNotification> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await _preferences.setString(_notificationsKey, encoded);
  }
}
