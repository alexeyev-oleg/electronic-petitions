import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_local_store.dart';
import 'inspector_triage_action.dart';
import 'mock_triage_repository.dart';
import 'triage_report.dart';
import 'triage_repository.dart';

enum TriageStatusFilter {
  all,
  triage,
  reviewRequired,
}

enum TriageTrustFilter {
  all,
  standard,
  lowGeoConfidence,
}

final triageRepositoryProvider = Provider<TriageRepository>(
  (ref) => MockTriageRepository(ref.watch(mockLocalStoreProvider)),
);

final triageControllerProvider = ChangeNotifierProvider<TriageController>(
  (ref) => TriageController(
    repository: ref.watch(triageRepositoryProvider),
  )..load(),
);

class TriageController extends ChangeNotifier {
  TriageController({
    required TriageRepository repository,
  }) : _repository = repository;

  final TriageRepository _repository;

  List<TriageReport> _reports = const [];
  bool _isLoading = false;
  bool _hasLoadError = false;
  TriageStatusFilter _statusFilter = TriageStatusFilter.all;
  TriageTrustFilter _trustFilter = TriageTrustFilter.all;

  List<TriageReport> get reports => _reports;
  bool get isLoading => _isLoading;
  bool get hasLoadError => _hasLoadError;
  TriageStatusFilter get statusFilter => _statusFilter;
  TriageTrustFilter get trustFilter => _trustFilter;

  List<TriageReport> get filteredReports {
    return [
      for (final report in _reports)
        if (_matchesStatus(report) && _matchesTrust(report)) report,
    ];
  }

  bool _matchesStatus(TriageReport report) {
    final status = report.status.toLowerCase();
    switch (_statusFilter) {
      case TriageStatusFilter.all:
        return true;
      case TriageStatusFilter.triage:
        return status.contains('triage');
      case TriageStatusFilter.reviewRequired:
        return status.contains('review');
    }
  }

  bool _matchesTrust(TriageReport report) {
    final trust = report.trustLabel.toLowerCase();
    switch (_trustFilter) {
      case TriageTrustFilter.all:
        return true;
      case TriageTrustFilter.standard:
        return trust.contains('standard');
      case TriageTrustFilter.lowGeoConfidence:
        return trust.contains('low_geo');
    }
  }

  void setStatusFilter(TriageStatusFilter filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  void setTrustFilter(TriageTrustFilter filter) {
    _trustFilter = filter;
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

  Future<TriageReport?> applyAction({
    required String reportId,
    required InspectorTriageAction action,
    String? actionNote,
  }) async {
    try {
      final updated = await _repository.applyAction(
        reportId: reportId,
        action: action,
        actionNote: actionNote,
      );
      _reports = [
        for (final item in _reports)
          if (item.id == reportId) updated else item,
      ];
      notifyListeners();
      return updated;
    } on TriageActionException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
