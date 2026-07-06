import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_preferences.dart';
import 'preferences_repository.dart';

class SharedPreferencesRepository implements PreferencesRepository {
  SharedPreferencesRepository(this._preferences);

  final SharedPreferences _preferences;

  static const _localeKey = 'locale_code';
  static const _emailNotificationsKey = 'email_notifications';
  static const _pushNotificationsKey = 'push_notifications';
  static const _onboardingCompletedKey = 'onboarding_completed';

  @override
  Future<Locale> getLocale() async {
    final code = _preferences.getString(_localeKey);
    if (code == null || code.isEmpty) {
      return const Locale('en');
    }
    return Locale(code);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _preferences.setString(_localeKey, locale.languageCode);
  }

  @override
  Future<NotificationPreferences> getNotificationPreferences() async {
    return NotificationPreferences(
      emailEnabled: _preferences.getBool(_emailNotificationsKey) ?? true,
      pushEnabled: _preferences.getBool(_pushNotificationsKey) ?? true,
    );
  }

  @override
  Future<void> saveNotificationPreferences(
    NotificationPreferences preferences,
  ) async {
    await _preferences.setBool(
      _emailNotificationsKey,
      preferences.emailEnabled,
    );
    await _preferences.setBool(
      _pushNotificationsKey,
      preferences.pushEnabled,
    );
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _preferences.getBool(_onboardingCompletedKey) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    await _preferences.setBool(_onboardingCompletedKey, true);
  }
}
