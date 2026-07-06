import 'dart:async';

import '../../../core/mock/mock_id_helper.dart';
import '../../../core/mock/mock_local_store.dart';
import '../../../core/models/media_attachment.dart';
import 'complaint.dart';
import 'complaints_repository.dart';

class MockComplaintsRepository implements ComplaintsRepository {
  MockComplaintsRepository(this._store);

  final MockLocalStore _store;

  @override
  Future<Complaint> createComplaint({
    required String title,
    required String description,
    required String locationLabel,
    required bool geoMismatch,
    double? latitude,
    double? longitude,
    required List<MediaAttachment> mediaAttachments,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final items = await _store.readComplaints();
    final created = Complaint(
      id: MockIdHelper.nextId('c', items.map((item) => item.id)),
      title: title.trim(),
      description: description.trim(),
      status: mediaAttachments.isNotEmpty ? 'submitted_with_media' : 'submitted',
      locationLabel: locationLabel.trim(),
      latitude: latitude,
      longitude: longitude,
      geoMismatch: geoMismatch,
      mediaAttachments: List<MediaAttachment>.from(mediaAttachments),
    );
    final updated = [created, ...items];
    await _store.saveComplaints(updated);
    return created;
  }

  @override
  Future<Complaint?> fetchComplaintById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final items = await _store.readComplaints();
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Future<List<Complaint>> fetchComplaints() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _store.fetchComplaints();
  }
}
