import '../../../core/models/petition_attachment.dart';

class Petition {
  const Petition({
    required this.id,
    required this.title,
    required this.summary,
    required this.status,
    required this.signatureCount,
    required this.isOwnedByCurrentUser,
    this.attachments = const [],
  });

  final String id;
  final String title;
  final String summary;
  final String status;
  final int signatureCount;
  final bool isOwnedByCurrentUser;
  final List<PetitionAttachment> attachments;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'status': status,
      'signatureCount': signatureCount,
      'isOwnedByCurrentUser': isOwnedByCurrentUser,
      'attachments': attachments.map((item) => item.toJson()).toList(),
    };
  }

  factory Petition.fromJson(Map<String, dynamic> json) {
    final rawAttachments = json['attachments'] as List<dynamic>?;
    return Petition(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      status: json['status'] as String,
      signatureCount: json['signatureCount'] as int,
      isOwnedByCurrentUser: json['isOwnedByCurrentUser'] as bool,
      attachments: rawAttachments == null
          ? const []
          : rawAttachments
              .map(
                (item) =>
                    PetitionAttachment.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
