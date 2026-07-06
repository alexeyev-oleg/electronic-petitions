import 'dart:convert';

import 'mock_local_store.dart';
import 'shared_seed_bridge.dart';

enum MockSnapshotImportError {
  invalidJson,
  invalidFormat,
  versionMismatch,
}

class MockSnapshotImportResult {
  const MockSnapshotImportResult._({
    required this.ok,
    this.error,
  });

  final bool ok;
  final MockSnapshotImportError? error;

  factory MockSnapshotImportResult.success() =>
      const MockSnapshotImportResult._(ok: true);

  factory MockSnapshotImportResult.failure(MockSnapshotImportError error) =>
      MockSnapshotImportResult._(ok: false, error: error);
}

class MockSnapshotImporter {
  const MockSnapshotImporter._();

  static Future<MockSnapshotImportResult> importInspectorSnapshot({
    required MockLocalStore store,
    required String jsonText,
  }) async {
    final Map<String, dynamic> root;
    try {
      root = jsonDecode(jsonText) as Map<String, dynamic>;
    } catch (_) {
      return MockSnapshotImportResult.failure(MockSnapshotImportError.invalidJson);
    }

    if (root['format'] != 'gesher_mock_snapshot') {
      return MockSnapshotImportResult.failure(MockSnapshotImportError.invalidFormat);
    }

    final assetVersion = await SharedSeedBridge.seedVersion();
    if (root['seedVersion'] != assetVersion) {
      return MockSnapshotImportResult.failure(
        MockSnapshotImportError.versionMismatch,
      );
    }

    final data = root['data'] as Map<String, dynamic>? ?? const {};
    await store.saveTriageReports(SharedSeedBridge.toTriageReports(data));
    return MockSnapshotImportResult.success();
  }
}
