import 'dart:convert';

import 'package:flutter/services.dart';

import '../../features/triage/application/triage_report.dart';

/// Loads enforcement demo entities from `assets/mock/seed.json` (W3.1).
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

  static List<TriageReport> toTriageReports(Map<String, dynamic> root) {
    final items = root['enforcement'] as List<dynamic>? ?? const [];
    return items.map((item) {
      final json = item as Map<String, dynamic>;
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
        actionNote: json['actionNote'] as String?,
      );
    }).toList();
  }
}
