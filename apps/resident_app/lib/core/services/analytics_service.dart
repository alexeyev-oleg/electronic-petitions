import 'package:flutter/foundation.dart';

abstract class AnalyticsService {
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  });
}

class MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    debugPrint('analytics: $name ${parameters ?? const {}}');
  }
}

class NoOpAnalyticsService implements AnalyticsService {
  const NoOpAnalyticsService();

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {}
}
