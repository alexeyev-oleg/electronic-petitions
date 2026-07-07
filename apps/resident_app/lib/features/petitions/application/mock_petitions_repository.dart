import 'dart:async';

import '../../../core/mock/mock_id_helper.dart';
import '../../../core/mock/mock_local_store.dart';
import '../../../core/models/petition_attachment.dart';
import 'petition.dart';
import 'petitions_repository.dart';

class MockPetitionsRepository implements PetitionsRepository {
  MockPetitionsRepository(this._store);

  final MockLocalStore _store;

  @override
  Future<Petition> createPetition({
    required String title,
    required String summary,
    List<PetitionAttachment> attachments = const [],
  }) async {
    _validateAttachments(attachments);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final items = await _store.readPetitions();
    final created = Petition(
      id: MockIdHelper.nextId('p', items.map((item) => item.id)),
      title: title.trim(),
      summary: summary.trim(),
      status: 'draft',
      signatureCount: 0,
      signatureGoal: 500,
      isOwnedByCurrentUser: true,
      attachments: List<PetitionAttachment>.from(attachments),
    );
    final updated = [created, ...items];
    await _store.savePetitions(updated);
    return created;
  }

  @override
  Future<Petition> signPetition(String petitionId) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final items = await _store.readPetitions();
    final index = items.indexWhere((item) => item.id == petitionId);
    if (index == -1) {
      throw StateError('Petition not found');
    }

    final petition = items[index];
    if (petition.signedByCurrentUser) {
      return petition;
    }

    final updatedPetition = Petition(
      id: petition.id,
      title: petition.title,
      summary: petition.summary,
      status: petition.status,
      signatureCount: petition.signatureCount + 1,
      signatureGoal: petition.signatureGoal,
      isOwnedByCurrentUser: petition.isOwnedByCurrentUser,
      signedByCurrentUser: true,
      attachments: petition.attachments,
    );
    final updated = [...items];
    updated[index] = updatedPetition;
    await _store.savePetitions(updated);
    return updatedPetition;
  }

  @override
  Future<Petition?> fetchPetitionById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final items = await _store.readPetitions();
    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  @override
  Future<List<Petition>> fetchPetitions() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _store.fetchPetitions();
  }

  @override
  Future<List<Petition>> fetchMyPetitions() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final items = await _store.readPetitions();
    return items.where((item) => item.isOwnedByCurrentUser).toList();
  }

  void _validateAttachments(List<PetitionAttachment> attachments) {
    final limitError = PetitionAttachment.validateAttachmentCount(
      attachments.length,
    );
    if (limitError != null) {
      throw ArgumentError(limitError);
    }

    for (final attachment in attachments) {
      final kindError = PetitionAttachment.validateKind(attachment.kind);
      if (kindError != null) {
        throw ArgumentError(kindError);
      }
    }
  }
}
