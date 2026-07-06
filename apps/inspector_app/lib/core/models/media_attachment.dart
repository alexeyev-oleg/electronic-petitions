enum MediaKind {
  photo,
  video,
}

class MediaAttachment {
  const MediaAttachment({
    required this.path,
    required this.kind,
    this.exifLatitude,
    this.exifLongitude,
  });

  final String path;
  final MediaKind kind;
  final double? exifLatitude;
  final double? exifLongitude;

  bool get isVideo => kind == MediaKind.video;

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'kind': kind.name,
      'exifLatitude': exifLatitude,
      'exifLongitude': exifLongitude,
    };
  }

  factory MediaAttachment.fromJson(Map<String, dynamic> json) {
    return MediaAttachment(
      path: json['path'] as String,
      kind: MediaKind.values.byName(json['kind'] as String),
      exifLatitude: (json['exifLatitude'] as num?)?.toDouble(),
      exifLongitude: (json['exifLongitude'] as num?)?.toDouble(),
    );
  }
}
