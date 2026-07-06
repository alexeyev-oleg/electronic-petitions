import 'dart:async';

import '../../../core/mock/mock_id_helper.dart';
import '../../../core/mock/mock_local_store.dart';
import '../../../core/models/media_attachment.dart';
import 'enforcement_report.dart';
import 'enforcement_repository.dart';

class MockEnforcementRepository implements EnforcementRepository {
  MockEnforcementRepository(this._store);

  final MockLocalStore _store;

  @override
  Future<EnforcementReport> createReport({
    required String title,
    required String description,
    required String locationLabel,
    required bool geoMismatch,
    double? latitude,
    double? longitude,
    required List<MediaAttachment> mediaAttachments,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final items = await _store.readEnforcementReports();
    final created = EnforcementReport(
      id: MockIdHelper.nextId('e', items.map((item) => item.id)),
      title: title.trim(),
      description: description.trim(),
      status: geoMismatch ? 'review_required' : 'submitted',
      locationLabel: locationLabel.trim(),
      latitude: latitude,
      longitude: longitude,
      geoMismatch: geoMismatch,
      trustLabel: geoMismatch ? 'low_geo_confidence' : 'standard',
      mediaAttachments: List<MediaAttachment>.from(mediaAttachments),
    );
    final updated = [created, ...items];
    await _store.saveEnforcementReports(updated);
    return created;
  }

  @override
  Future<EnforcementReport?> fetchReportById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final items = await _store.readEnforcementReports();
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Future<List<EnforcementReport>> fetchReports() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _store.fetchEnforcementReports();
  }
}
