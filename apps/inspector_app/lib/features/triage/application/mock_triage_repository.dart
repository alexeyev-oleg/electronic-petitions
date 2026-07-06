import '../../../core/mock/mock_local_store.dart';
import 'inspector_triage_action.dart';
import 'triage_report.dart';
import 'triage_repository.dart';

class TriageActionException implements Exception {
  const TriageActionException(this.code);

  final String code;
}

class MockTriageRepository implements TriageRepository {
  MockTriageRepository(this._store);

  final MockLocalStore _store;

  @override
  Future<List<TriageReport>> fetchTriageReports() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _store.readTriageReports();
  }

  @override
  Future<TriageReport?> fetchReportById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final items = await _store.readTriageReports();
    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  @override
  Future<TriageReport> applyAction({
    required String reportId,
    required InspectorTriageAction action,
    String? actionNote,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final items = await _store.readTriageReports();
    final index = items.indexWhere((item) => item.id == reportId);
    if (index == -1) {
      throw const TriageActionException('report_not_found');
    }

    final report = items[index];
    if (report.isClosed) {
      throw const TriageActionException('report_already_closed');
    }

    if (action.requiresExistingDispatch && !report.canValidateOutcome) {
      throw const TriageActionException('dispatch_required');
    }

    if (!action.requiresExistingDispatch && !report.canApplyTriageActions) {
      throw const TriageActionException('triage_action_not_allowed');
    }

    final updated = report.copyWith(
      status: action.resultingStatus,
      actionNote: actionNote,
    );
    final next = [...items];
    next[index] = updated;
    await _store.saveTriageReports(next);
    return updated;
  }
}
