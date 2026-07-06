import 'package:flutter/material.dart';

import '../models/notification_preferences.dart';
import 'preferences_repository.dart';

class MockPreferencesRepository implements PreferencesRepository {
  Locale _locale = const Locale('en');
  NotificationPreferences _notificationPreferences =
      const NotificationPreferences(
        emailEnabled: true,
        pushEnabled: true,
      );

  @override
  Future<Locale> getLocale() async {
    return _locale;
  }

  @override
  Future<NotificationPreferences> getNotificationPreferences() async {
    return _notificationPreferences;
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    _locale = locale;
  }

  @override
  Future<void> saveNotificationPreferences(
    NotificationPreferences preferences,
  ) async {
    _notificationPreferences = preferences;
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _onboardingCompleted;
  }

  @override
  Future<void> completeOnboarding() async {
    _onboardingCompleted = true;
  }

  bool _onboardingCompleted = false;
}
