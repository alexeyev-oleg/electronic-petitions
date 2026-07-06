import 'dart:convert';

import 'package:flutter/services.dart';

import '../../features/complaints/application/complaint.dart';
import '../../features/enforcement/application/enforcement_report.dart';
import '../../features/notifications/application/app_notification.dart';
import '../../features/petitions/application/petition.dart';

/// Loads canonical demo entities from `assets/mock/seed.json` (W3.1).
class SharedSeedBridge {
  static const assetPath = 'assets/mock/seed.json';

  static Future<Map<String, dynamic>> loadRoot() async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<String> seedVersion() async {
    final root = await loadRoot();
    return root['version'] as String? ?? '0.0.0';
  }

  static List<Petition> toPetitions(Map<String, dynamic> root) {
    final items = root['petitions'] as List<dynamic>? ?? const [];
    return items
        .map((item) {
          final json = item as Map<String, dynamic>;
          return Petition(
            id: json['id'] as String,
            title: json['title'] as String,
            summary: json['summary'] as String,
            status: json['status'] as String,
            signatureCount: json['signatureCount'] as int? ?? 0,
            isOwnedByCurrentUser: json['isOwnedByCurrentUser'] as bool? ?? false,
          );
        })
        .toList();
  }

  static List<Complaint> toComplaints(Map<String, dynamic> root) {
    final items = root['complaints'] as List<dynamic>? ?? const [];
    return items
        .map((item) => Complaint.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<EnforcementReport> toEnforcementReports(
    Map<String, dynamic> root,
  ) {
    final items = root['enforcement'] as List<dynamic>? ?? const [];
    return items
        .map((item) => EnforcementReport.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<AppNotification> toNotifications(Map<String, dynamic> root) {
    final items = root['notifications'] as List<dynamic>? ?? const [];
    return items
        .map((item) => AppNotification.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
