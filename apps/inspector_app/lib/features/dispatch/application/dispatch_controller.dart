import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../triage/application/triage_controller.dart';
import '../../triage/application/triage_report.dart';
import '../../triage/application/triage_repository.dart';

enum DispatchStatusFilter {
  all,
  assigned,
  inField,
  completed,
}

final dispatchControllerProvider = ChangeNotifierProvider<DispatchController>(
  (ref) => DispatchController(
    repository: ref.watch(triageRepositoryProvider),
  )..load(),
);

class DispatchController extends ChangeNotifier {
  DispatchController({
    required TriageRepository repository,
  }) : _repository = repository;

  final TriageRepository _repository;

  List<TriageReport> _reports = const [];
  bool _isLoading = false;
  bool _hasLoadError = false;
  DispatchStatusFilter _statusFilter = DispatchStatusFilter.all;

  List<TriageReport> get reports => _reports;
  bool get isLoading => _isLoading;
  bool get hasLoadError => _hasLoadError;
  DispatchStatusFilter get statusFilter => _statusFilter;

  List<TriageReport> get filteredReports {
    return [
      for (final report in _reports)
        if (report.isDispatchQueueItem && _matchesStatus(report)) report,
    ];
  }

  bool _matchesStatus(TriageReport report) {
    final status = report.status.toLowerCase();
    switch (_statusFilter) {
      case DispatchStatusFilter.all:
        return true;
      case DispatchStatusFilter.assigned:
        return status.contains('dispatch_task');
      case DispatchStatusFilter.inField:
        return status.contains('field_in_progress');
      case DispatchStatusFilter.completed:
        return status.contains('validated');
    }
  }

  void setStatusFilter(DispatchStatusFilter filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  Future<void> load() async {
    _isLoading = true;
    _hasLoadError = false;
    notifyListeners();

    try {
      _reports = await _repository.fetchTriageReports();
    } catch (_) {
      _hasLoadError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  TriageReport? findById(String id) {
    for (final item in _reports) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}
