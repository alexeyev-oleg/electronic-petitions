import '../../../core/models/media_attachment.dart';
import 'enforcement_report.dart';

abstract class EnforcementRepository {
  Future<List<EnforcementReport>> fetchReports();
  Future<EnforcementReport?> fetchReportById(String id);
  Future<EnforcementReport> createReport({
    required String title,
    required String description,
    required String locationLabel,
    required bool geoMismatch,
    double? latitude,
    double? longitude,
    required List<MediaAttachment> mediaAttachments,
  });
}
