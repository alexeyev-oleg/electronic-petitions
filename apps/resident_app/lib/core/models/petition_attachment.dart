const petitionMaxAttachments = 5;

enum PetitionAttachmentKind {
  photo,
  pdf,
  doc,
  excel,
}

class PetitionAttachment {
  const PetitionAttachment({
    required this.path,
    required this.kind,
    required this.displayName,
  });

  final String path;
  final PetitionAttachmentKind kind;
  final String displayName;

  bool get isPhoto => kind == PetitionAttachmentKind.photo;

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'kind': kind.name,
      'displayName': displayName,
    };
  }

  factory PetitionAttachment.fromJson(Map<String, dynamic> json) {
    return PetitionAttachment(
      path: json['path'] as String,
      kind: PetitionAttachmentKind.values.byName(json['kind'] as String),
      displayName: json['displayName'] as String,
    );
  }

  static PetitionAttachmentKind? kindForExtension(String extension) {
    final normalized = extension.toLowerCase().replaceFirst('.', '');
    switch (normalized) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'webp':
      case 'heic':
        return PetitionAttachmentKind.photo;
      case 'pdf':
        return PetitionAttachmentKind.pdf;
      case 'doc':
      case 'docx':
        return PetitionAttachmentKind.doc;
      case 'xls':
      case 'xlsx':
        return PetitionAttachmentKind.excel;
      default:
        return null;
    }
  }

  static PetitionAttachmentKind? kindForPath(String path) {
    final dotIndex = path.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == path.length - 1) {
      return null;
    }
    return kindForExtension(path.substring(dotIndex));
  }

  static String? validateAttachmentCount(int count) {
    if (count > petitionMaxAttachments) {
      return 'petition_attachment_limit_exceeded';
    }
    return null;
  }

  static String? validateKind(PetitionAttachmentKind kind) {
    if (kind == PetitionAttachmentKind.photo ||
        kind == PetitionAttachmentKind.pdf ||
        kind == PetitionAttachmentKind.doc ||
        kind == PetitionAttachmentKind.excel) {
      return null;
    }
    return 'petition_attachment_type_not_allowed';
  }
}
