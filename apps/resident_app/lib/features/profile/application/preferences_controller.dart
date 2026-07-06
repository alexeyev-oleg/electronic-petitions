import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../shared/models/notification_preferences.dart';
import '../../../shared/repositories/preferences_repository.dart';
import '../../../shared/repositories/preferences_repository_provider.dart';

final preferencesControllerProvider =
    ChangeNotifierProvider<PreferencesController>((ref) {
  final repository = ref.watch(preferencesRepositoryProvider);
  return PreferencesController(repository: repository);
});

class PreferencesController extends ChangeNotifier {
  PreferencesController({
    required PreferencesRepository repository,
  }) : _repository = repository;

  final PreferencesRepository _repository;

  Locale _locale = AppLocalizations.supportedLocales.first;
  NotificationPreferences _notificationPreferences =
      const NotificationPreferences(
    emailEnabled: true,
    pushEnabled: true,
      );
  bool _onboardingCompleted = false;
  bool _isLoading = true;
  Future<void>? _initFuture;

  Locale get locale => _locale;
  NotificationPreferences get notificationPreferences =>
      _notificationPreferences;
  bool get onboardingCompleted => _onboardingCompleted;
  bool get isLoading => _isLoading;

  Future<void> ensureInitialized() {
    return _initFuture ??= _initialize();
  }

  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    _locale = await _repository.getLocale();
    _notificationPreferences =
        await _repository.getNotificationPreferences();
    _onboardingCompleted = await _repository.isOnboardingCompleted();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    await _repository.saveLocale(locale);
  }

  Future<void> updateNotificationPreferences(
    NotificationPreferences preferences,
  ) async {
    _notificationPreferences = preferences;
    notifyListeners();
    await _repository.saveNotificationPreferences(preferences);
  }

  Future<void> completeOnboarding() async {
    _onboardingCompleted = true;
    notifyListeners();
    await _repository.completeOnboarding();
  }
}
