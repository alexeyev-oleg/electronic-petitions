class InspectorUser {
  const InspectorUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.badgeId,
    required this.role,
  });

  final String id;
  final String email;
  final String fullName;
  final String badgeId;
  final String role;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'badgeId': badgeId,
      'role': role,
    };
  }

  factory InspectorUser.fromJson(Map<String, dynamic> json) {
    return InspectorUser(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      badgeId: json['badgeId'] as String,
      role: json['role'] as String,
    );
  }
}
