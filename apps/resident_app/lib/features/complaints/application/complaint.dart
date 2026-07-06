import '../../../core/models/media_attachment.dart';

class Complaint {
  const Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.locationLabel,
    this.latitude,
    this.longitude,
    this.geoMismatch = false,
    this.mediaAttachments = const [],
  });

  final String id;
  final String title;
  final String description;
  final String status;
  final String locationLabel;
  final double? latitude;
  final double? longitude;
  final bool geoMismatch;
  final List<MediaAttachment> mediaAttachments;

  bool get hasMedia => mediaAttachments.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'locationLabel': locationLabel,
      'latitude': latitude,
      'longitude': longitude,
      'geoMismatch': geoMismatch,
      'mediaAttachments':
          mediaAttachments.map((item) => item.toJson()).toList(),
    };
  }

  factory Complaint.fromJson(Map<String, dynamic> json) {
    final media = json['mediaAttachments'] as List<dynamic>? ?? const [];
    return Complaint(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      locationLabel: json['locationLabel'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      geoMismatch: json['geoMismatch'] as bool? ?? false,
      mediaAttachments: media
          .map((item) => MediaAttachment.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
