import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_local_store.dart';
import '../../../core/models/media_attachment.dart';
import 'enforcement_report.dart';
import 'enforcement_repository.dart';
import 'mock_enforcement_repository.dart';

final enforcementRepositoryProvider = Provider<EnforcementRepository>(
  (ref) => MockEnforcementRepository(ref.watch(mockLocalStoreProvider)),
);

final enforcementControllerProvider =
    ChangeNotifierProvider<EnforcementController>(
  (ref) => EnforcementController(
    repository: ref.watch(enforcementRepositoryProvider),
  )..load(),
);

class EnforcementController extends ChangeNotifier {
  EnforcementController({
    required EnforcementRepository repository,
  }) : _repository = repository;

  final EnforcementRepository _repository;

  List<EnforcementReport> _reports = const [];
  bool _isLoading = false;
  bool _hasLoadError = false;

  List<EnforcementReport> get reports => _reports;
  bool get isLoading => _isLoading;
  bool get hasLoadError => _hasLoadError;

  Future<void> load() async {
    _isLoading = true;
    _hasLoadError = false;
    notifyListeners();

    try {
      _reports = await _repository.fetchReports();
    } catch (_) {
      _hasLoadError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  EnforcementReport? findById(String id) {
    for (final item in _reports) {
      if (item.id == id) return item;
    }
    return null;
  }

  Future<EnforcementReport> createReport({
    required String title,
    required String description,
    required String locationLabel,
    required bool geoMismatch,
    double? latitude,
    double? longitude,
    required List<MediaAttachment> mediaAttachments,
  }) async {
    final created = await _repository.createReport(
      title: title,
      description: description,
      locationLabel: locationLabel,
      geoMismatch: geoMismatch,
      latitude: latitude,
      longitude: longitude,
      mediaAttachments: mediaAttachments,
    );
    _reports = [created, ..._reports];
    notifyListeners();
    return created;
  }
}
