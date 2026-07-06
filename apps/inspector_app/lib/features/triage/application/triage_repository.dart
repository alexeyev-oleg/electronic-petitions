import 'inspector_triage_action.dart';
import 'triage_report.dart';

abstract class TriageRepository {
  Future<List<TriageReport>> fetchTriageReports();
  Future<TriageReport?> fetchReportById(String id);
  Future<TriageReport> applyAction({
    required String reportId,
    required InspectorTriageAction action,
    String? actionNote,
  });
}
