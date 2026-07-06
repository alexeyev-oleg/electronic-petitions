import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF0057B8);
  static const primaryDark = Color(0xFF003D82);
  static const secondary = Color(0xFF00897B);
  static const surfaceMuted = Color(0xFFF4F7FB);
  static const outline = Color(0xFFD7E0EA);

  static const statusPending = Color(0xFFF59E0B);
  static const statusActive = Color(0xFF2563EB);
  static const statusSuccess = Color(0xFF059669);
  static const statusNeutral = Color(0xFF64748B);
  static const statusWarning = Color(0xFFDC2626);

  static Color statusBackground(String status) {
    return statusColor(status).withValues(alpha: 0.12);
  }

  static Color statusColor(String status) {
    final normalized = status.toLowerCase();

    if (normalized.contains('draft') ||
        normalized.contains('moderation') ||
        normalized.contains('triage') ||
        normalized.contains('review')) {
      return statusPending;
    }

    if (normalized.contains('progress') ||
        normalized.contains('published') ||
        normalized.contains('submitted')) {
      return statusActive;
    }

    if (normalized.contains('resolved') ||
        normalized.contains('approved') ||
        normalized.contains('closed_ok')) {
      return statusSuccess;
    }

    if (normalized.contains('rejected') || normalized.contains('failed')) {
      return statusWarning;
    }

    return statusNeutral;
  }
}
