import '../../features/triage/application/triage_report.dart';

class InspectorQueueStats {
  const InspectorQueueStats({
    required this.triageOpen,
    required this.lowTrust,
    required this.dispatchActive,
    required this.dispatchCompleted,
  });

  final int triageOpen;
  final int lowTrust;
  final int dispatchActive;
  final int dispatchCompleted;

  factory InspectorQueueStats.fromReports(List<TriageReport> reports) {
    var triageOpen = 0;
    var lowTrust = 0;
    var dispatchActive = 0;
    var dispatchCompleted = 0;

    for (final report in reports) {
      final status = report.status.toLowerCase();
      final trust = report.trustLabel.toLowerCase();

      if (!report.isClosed && trust.contains('low_geo')) {
        lowTrust++;
      }

      if (report.isDispatchQueueItem) {
        if (status.contains('validated')) {
          dispatchCompleted++;
        } else {
          dispatchActive++;
        }
        continue;
      }

      if (status.contains('triage') || status.contains('review')) {
        triageOpen++;
      }
    }

    return InspectorQueueStats(
      triageOpen: triageOpen,
      lowTrust: lowTrust,
      dispatchActive: dispatchActive,
      dispatchCompleted: dispatchCompleted,
    );
  }
}
