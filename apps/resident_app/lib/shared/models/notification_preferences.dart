class NotificationPreferences {
  const NotificationPreferences({
    required this.emailEnabled,
    required this.pushEnabled,
  });

  final bool emailEnabled;
  final bool pushEnabled;

  NotificationPreferences copyWith({
    bool? emailEnabled,
    bool? pushEnabled,
  }) {
    return NotificationPreferences(
      emailEnabled: emailEnabled ?? this.emailEnabled,
      pushEnabled: pushEnabled ?? this.pushEnabled,
    );
  }
}
