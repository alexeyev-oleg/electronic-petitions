import 'package:flutter/material.dart';

import '../models/notification_preferences.dart';

abstract class PreferencesRepository {
  Future<Locale> getLocale();
  Future<void> saveLocale(Locale locale);

  Future<NotificationPreferences> getNotificationPreferences();
  Future<void> saveNotificationPreferences(
    NotificationPreferences preferences,
  );

  Future<bool> isOnboardingCompleted();
  Future<void> completeOnboarding();
}
