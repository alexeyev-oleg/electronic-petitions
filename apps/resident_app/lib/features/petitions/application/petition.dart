import '../../../core/models/petition_attachment.dart';

class Petition {
  const Petition({
    required this.id,
    required this.title,
    required this.summary,
    required this.status,
    required this.signatureCount,
    required this.signatureGoal,
    required this.isOwnedByCurrentUser,
    this.signedByCurrentUser = false,
    this.attachments = const [],
  });

  final String id;
  final String title;
  final String summary;
  final String status;
  final int signatureCount;
  final int signatureGoal;
  final bool isOwnedByCurrentUser;
  final bool signedByCurrentUser;
  final List<PetitionAttachment> attachments;

  double get signatureProgress {
    if (signatureGoal <= 0) {
      return 0;
    }
    return (signatureCount / signatureGoal).clamp(0, 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'status': status,
      'signatureCount': signatureCount,
      'signatureGoal': signatureGoal,
      'isOwnedByCurrentUser': isOwnedByCurrentUser,
      'signedByCurrentUser': signedByCurrentUser,
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
      signatureCount: json['signatureCount'] as int? ?? 0,
      signatureGoal: json['signatureGoal'] as int? ?? 500,
      isOwnedByCurrentUser: json['isOwnedByCurrentUser'] as bool? ?? false,
      signedByCurrentUser: json['signedByCurrentUser'] as bool? ?? false,
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
