import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../monitoring/app_monitoring.dart';
import '../services/analytics_service.dart';
import '../monitoring/crash_reporting_service.dart';

final analyticsServiceProvider = Provider<AnalyticsService>(
  (_) => AppMonitoring.analytics,
);

final crashReportingServiceProvider = Provider<CrashReportingService>(
  (_) => AppMonitoring.crashReporting,
);
