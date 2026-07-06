import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_local_store.dart';
import '../../../core/models/media_attachment.dart';
import 'complaint.dart';
import 'complaints_repository.dart';
import 'mock_complaints_repository.dart';

final complaintsRepositoryProvider = Provider<ComplaintsRepository>(
  (ref) => MockComplaintsRepository(ref.watch(mockLocalStoreProvider)),
);

final complaintsControllerProvider = ChangeNotifierProvider<ComplaintsController>(
  (ref) => ComplaintsController(
    repository: ref.watch(complaintsRepositoryProvider),
  )..load(),
);

class ComplaintsController extends ChangeNotifier {
  ComplaintsController({
    required ComplaintsRepository repository,
  }) : _repository = repository;

  final ComplaintsRepository _repository;

  List<Complaint> _complaints = const [];
  bool _isLoading = false;
  bool _hasLoadError = false;

  List<Complaint> get complaints => _complaints;
  bool get isLoading => _isLoading;
  bool get hasLoadError => _hasLoadError;

  Future<void> load() async {
    _isLoading = true;
    _hasLoadError = false;
    notifyListeners();

    try {
      _complaints = await _repository.fetchComplaints();
    } catch (_) {
      _hasLoadError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Complaint? findById(String id) {
    for (final item in _complaints) {
      if (item.id == id) return item;
    }
    return null;
  }

  Future<Complaint> createComplaint({
    required String title,
    required String description,
    required String locationLabel,
    required bool geoMismatch,
    double? latitude,
    double? longitude,
    required List<MediaAttachment> mediaAttachments,
  }) async {
    final created = await _repository.createComplaint(
      title: title,
      description: description,
      locationLabel: locationLabel,
      geoMismatch: geoMismatch,
      latitude: latitude,
      longitude: longitude,
      mediaAttachments: mediaAttachments,
    );
    _complaints = [created, ..._complaints];
    notifyListeners();
    return created;
  }
}
