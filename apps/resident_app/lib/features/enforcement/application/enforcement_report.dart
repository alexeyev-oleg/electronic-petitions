import '../../../core/models/media_attachment.dart';

class EnforcementReport {
  const EnforcementReport({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.locationLabel,
    required this.geoMismatch,
    required this.trustLabel,
    this.latitude,
    this.longitude,
    this.mediaAttachments = const [],
  });

  final String id;
  final String title;
  final String description;
  final String status;
  final String locationLabel;
  final bool geoMismatch;
  final String trustLabel;
  final double? latitude;
  final double? longitude;
  final List<MediaAttachment> mediaAttachments;

  bool get hasMedia => mediaAttachments.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'locationLabel': locationLabel,
      'geoMismatch': geoMismatch,
      'trustLabel': trustLabel,
      'latitude': latitude,
      'longitude': longitude,
      'mediaAttachments':
          mediaAttachments.map((item) => item.toJson()).toList(),
    };
  }

  factory EnforcementReport.fromJson(Map<String, dynamic> json) {
    final media = json['mediaAttachments'] as List<dynamic>? ?? const [];
    return EnforcementReport(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      locationLabel: json['locationLabel'] as String,
      geoMismatch: json['geoMismatch'] as bool? ?? false,
      trustLabel: json['trustLabel'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      mediaAttachments: media
          .map((item) => MediaAttachment.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
