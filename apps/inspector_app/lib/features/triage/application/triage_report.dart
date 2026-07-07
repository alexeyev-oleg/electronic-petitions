import '../../../core/models/media_attachment.dart';

class TriageReport {
  const TriageReport({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.locationLabel,
    required this.geoMismatch,
    required this.trustLabel,
    required this.submittedAtLabel,
    this.latitude,
    this.longitude,
    this.mediaAttachments = const [],
    this.actionNote,
    this.oversightNote,
  });

  final String id;
  final String title;
  final String description;
  final String status;
  final String locationLabel;
  final bool geoMismatch;
  final String trustLabel;
  final String submittedAtLabel;
  final double? latitude;
  final double? longitude;
  final List<MediaAttachment> mediaAttachments;
  final String? actionNote;
  final String? oversightNote;

  bool get hasMedia => mediaAttachments.isNotEmpty;

  bool get canApplyTriageActions {
    final normalized = status.toLowerCase();
    return normalized.contains('triage') || normalized.contains('review');
  }

  bool get canValidateOutcome {
    final normalized = status.toLowerCase();
    return normalized.contains('dispatch') ||
        normalized.contains('field_in_progress');
  }

  bool get canStartFieldVisit => status.toLowerCase().contains('dispatch_task');

  bool get isDispatchQueueItem {
    final normalized = status.toLowerCase();
    return normalized.contains('dispatch') ||
        normalized.contains('field_in_progress') ||
        normalized.contains('validated');
  }

  bool get isClosed {
    final normalized = status.toLowerCase();
    return normalized.contains('invalid') ||
        normalized.contains('merged') ||
        normalized.contains('validated');
  }

  TriageReport copyWith({
    String? status,
    String? actionNote,
    String? oversightNote,
  }) {
    return TriageReport(
      id: id,
      title: title,
      description: description,
      status: status ?? this.status,
      locationLabel: locationLabel,
      geoMismatch: geoMismatch,
      trustLabel: trustLabel,
      submittedAtLabel: submittedAtLabel,
      latitude: latitude,
      longitude: longitude,
      mediaAttachments: mediaAttachments,
      actionNote: actionNote ?? this.actionNote,
      oversightNote: oversightNote ?? this.oversightNote,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'locationLabel': locationLabel,
      'geoMismatch': geoMismatch,
      'trustLabel': trustLabel,
      'submittedAtLabel': submittedAtLabel,
      'latitude': latitude,
      'longitude': longitude,
      'mediaAttachments':
          mediaAttachments.map((item) => item.toJson()).toList(),
      'actionNote': actionNote,
      'oversightNote': oversightNote,
    };
  }

  factory TriageReport.fromJson(Map<String, dynamic> json) {
    final media = json['mediaAttachments'] as List<dynamic>? ?? const [];
    return TriageReport(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      locationLabel: json['locationLabel'] as String,
      geoMismatch: json['geoMismatch'] as bool? ?? false,
      trustLabel: json['trustLabel'] as String,
      submittedAtLabel: json['submittedAtLabel'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      mediaAttachments: media
          .map((item) => MediaAttachment.fromJson(item as Map<String, dynamic>))
          .toList(),
      actionNote: json['actionNote'] as String?,
      oversightNote: json['oversightNote'] as String?,
    );
  }
}
