import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_local_store.dart';
import '../../../core/models/petition_attachment.dart';
import 'mock_petitions_repository.dart';
import 'petition.dart';
import 'petitions_repository.dart';

enum PetitionStatusFilter {
  all,
  published,
  inReview,
  draft,
}

final petitionsRepositoryProvider = Provider<PetitionsRepository>(
  (ref) => MockPetitionsRepository(ref.watch(mockLocalStoreProvider)),
);

final petitionsControllerProvider = ChangeNotifierProvider<PetitionsController>(
  (ref) => PetitionsController(
    repository: ref.watch(petitionsRepositoryProvider),
  )..load(),
);

class PetitionsController extends ChangeNotifier {
  PetitionsController({
    required PetitionsRepository repository,
  }) : _repository = repository;

  final PetitionsRepository _repository;

  List<Petition> _petitions = const [];
  bool _isLoading = false;
  bool _hasLoadError = false;
  String _searchQuery = '';
  PetitionStatusFilter _statusFilter = PetitionStatusFilter.all;

  List<Petition> get petitions => _petitions;
  bool get isLoading => _isLoading;
  bool get hasLoadError => _hasLoadError;
  String get searchQuery => _searchQuery;
  PetitionStatusFilter get statusFilter => _statusFilter;
  List<Petition> get myPetitions =>
      _petitions.where((item) => item.isOwnedByCurrentUser).toList();

  List<Petition> get filteredPetitions {
    final query = _searchQuery.trim().toLowerCase();
    return [
      for (final petition in _petitions)
        if (_matchesFilter(petition) &&
            (query.isEmpty ||
                petition.title.toLowerCase().contains(query) ||
                petition.summary.toLowerCase().contains(query)))
          petition,
    ];
  }

  bool _matchesFilter(Petition petition) {
    final status = petition.status.toLowerCase();
    switch (_statusFilter) {
      case PetitionStatusFilter.all:
        return true;
      case PetitionStatusFilter.published:
        return status.contains('published');
      case PetitionStatusFilter.inReview:
        return status.contains('moderation') || status.contains('review');
      case PetitionStatusFilter.draft:
        return status.contains('draft');
    }
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setStatusFilter(PetitionStatusFilter filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  Future<void> load() async {
    _isLoading = true;
    _hasLoadError = false;
    notifyListeners();

    try {
      _petitions = await _repository.fetchPetitions();
    } catch (_) {
      _hasLoadError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Petition? findById(String id) {
    for (final item in _petitions) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Future<Petition> createPetition({
    required String title,
    required String summary,
    List<PetitionAttachment> attachments = const [],
  }) async {
    final created = await _repository.createPetition(
      title: title,
      summary: summary,
      attachments: attachments,
    );
    _petitions = [created, ..._petitions];
    notifyListeners();
    return created;
  }

  Future<Petition?> signPetition(String petitionId) async {
    try {
      final updated = await _repository.signPetition(petitionId);
      _petitions = [
        for (final item in _petitions)
          if (item.id == petitionId) updated else item,
      ];
      notifyListeners();
      return updated;
    } catch (_) {
      return null;
    }
  }
}
