import 'dart:convert';

import 'mock_local_store.dart';
import 'shared_seed_bridge.dart';

class MockSnapshotExporter {
  const MockSnapshotExporter._();

  static Future<String> exportResidentSnapshot({
    required MockLocalStore store,
  }) async {
    final version = await SharedSeedBridge.seedVersion();
    final data = <String, dynamic>{
      'petitions': (await store.readPetitions()).map((item) => item.toJson()).toList(),
      'complaints': (await store.readComplaints()).map((item) => item.toJson()).toList(),
      'enforcement': (await store.readEnforcementReports())
          .map((item) => item.toJson())
          .toList(),
      'notifications': (await store.readNotifications())
          .map((item) => item.toJson())
          .toList(),
    };

    return const JsonEncoder.withIndent('  ').convert({
      'format': 'gesher_mock_snapshot',
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'seedVersion': version,
      'data': data,
    });
  }
}
