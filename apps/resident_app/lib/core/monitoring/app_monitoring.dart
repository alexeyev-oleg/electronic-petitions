import 'package:flutter/foundation.dart';

import '../../app/environment/app_environment.dart';
import '../services/analytics_service.dart';
import 'crash_reporting_service.dart';

class AppMonitoring {
  static AnalyticsService? _analytics;
  static CrashReportingService? _crashReporting;

  static AnalyticsService get analytics =>
      _analytics ?? const NoOpAnalyticsService();

  static CrashReportingService get crashReporting =>
      _crashReporting ?? const NoOpCrashReportingService();

  static Future<void> initialize(AppEnvironment environment) async {
    _analytics = environment.enableAnalytics
        ? MockAnalyticsService()
        : const NoOpAnalyticsService();
    _crashReporting = environment.enableCrashReporting
        ? MockCrashReportingService()
        : const NoOpCrashReportingService();

    await _crashReporting!.initialize();
    await _analytics!.logEvent(name: 'app_start', parameters: {
      'flavor': environment.flavor.name,
    });
  }

  static Future<void> recordError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
  }) async {
    await _crashReporting?.recordError(
      error,
      stackTrace,
      reason: reason,
    );
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
