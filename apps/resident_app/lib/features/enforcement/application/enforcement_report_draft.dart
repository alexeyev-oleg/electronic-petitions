import '../../../core/models/media_attachment.dart';

class EnforcementReportDraft {
  const EnforcementReportDraft({
    required this.title,
    required this.description,
    required this.locationLabel,
    required this.geoMismatch,
    this.latitude,
    this.longitude,
    this.mediaAttachments = const [],
  });

  final String title;
  final String description;
  final String locationLabel;
  final bool geoMismatch;
  final double? latitude;
  final double? longitude;
  final List<MediaAttachment> mediaAttachments;

  bool get hasMedia => mediaAttachments.isNotEmpty;
}
