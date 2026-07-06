import 'package:flutter/foundation.dart';

abstract class CrashReportingService {
  Future<void> initialize();

  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  });
}

class MockCrashReportingService implements CrashReportingService {
  @override
  Future<void> initialize() async {
    debugPrint('crash_reporting: initialized (mock)');
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {
    debugPrint(
      'crash_reporting: ${reason ?? 'error'} -> $error',
    );
  }
}

class NoOpCrashReportingService implements CrashReportingService {
  const NoOpCrashReportingService();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {}
}
