class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAtLabel,
    required this.isRead,
  });

  final String id;
  final String title;
  final String body;
  final String createdAtLabel;
  final bool isRead;

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    String? createdAtLabel,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAtLabel: createdAtLabel ?? this.createdAtLabel,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAtLabel': createdAtLabel,
      'isRead': isRead,
    };
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      createdAtLabel: json['createdAtLabel'] as String,
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}
