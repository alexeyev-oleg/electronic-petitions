import 'package:flutter/material.dart';

abstract final class AppColors {
  static const terracotta = Color(0xFFC6643C);
  static const graphite = Color(0xFF2B2B2B);
  static const primary = terracotta;
  static const primaryDark = graphite;
  static const secondary = Color(0xFF00897B);
  static const surfaceMuted = Color(0xFFF4F7FB);
  static const outline = Color(0xFFD7E0EA);
  static const textMuted = Color(0xFF64748B);

  static const statusPending = Color(0xFFF59E0B);
  static const statusActive = Color(0xFFC6643C);
  static const statusSuccess = Color(0xFF059669);
  static const statusNeutral = Color(0xFF64748B);
  static const statusWarning = Color(0xFFDC2626);

  static Color statusBackground(String status) {
    return statusColor(status).withValues(alpha: 0.12);
  }

  static Color statusColor(String status) {
    final normalized = status.toLowerCase();

    if (normalized.contains('dispatch')) {
      return statusActive;
    }

    if (normalized.contains('validated') ||
        normalized.contains('resolved') ||
        normalized.contains('closed')) {
      return statusSuccess;
    }

    if (normalized.contains('invalid') || normalized.contains('rejected')) {
      return statusWarning;
    }

    if (normalized.contains('merged')) {
      return statusNeutral;
    }

    if (normalized.contains('triage') ||
        normalized.contains('review') ||
        normalized.contains('moderation')) {
      return statusPending;
    }

    if (normalized.contains('progress') || normalized.contains('published')) {
      return statusActive;
    }

    return statusNeutral;
  }
}
