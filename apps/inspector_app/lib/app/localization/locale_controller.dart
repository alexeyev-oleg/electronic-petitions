import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/providers/shared_preferences_provider.dart';
import 'app_localizations.dart';

/// Stored separately from the mock store so it survives mock resets.
const inspectorLocaleKey = 'inspector_locale_code';

final localeControllerProvider = ChangeNotifierProvider<LocaleController>(
  (ref) => LocaleController(
    ref.watch(sharedPreferencesProvider),
    deviceLocales: WidgetsBinding.instance.platformDispatcher.locales,
  ),
);

/// App language: saved choice → device language (if supported) → English.
class LocaleController extends ChangeNotifier {
  LocaleController(
    this._preferences, {
    required List<Locale> deviceLocales,
  }) : _locale = resolveInitialLocale(
          savedCode: _preferences.getString(inspectorLocaleKey),
          deviceLocales: deviceLocales,
        );

  final SharedPreferences _preferences;
  Locale _locale;

  Locale get locale => _locale;

  bool get isRtl => isRtlLanguage(_locale.languageCode);

  static bool isRtlLanguage(String languageCode) =>
      languageCode == 'he' || languageCode == 'ar';

  static Locale resolveInitialLocale({
    required String? savedCode,
    required List<Locale> deviceLocales,
  }) {
    if (savedCode != null && _isSupported(savedCode)) {
      return Locale(savedCode);
    }
    for (final device in deviceLocales) {
      // Android reports Hebrew as the legacy code "iw".
      final code =
          device.languageCode == 'iw' ? 'he' : device.languageCode;
      if (_isSupported(code)) {
        return Locale(code);
      }
    }
    return const Locale('en');
  }

  static bool _isSupported(String code) => AppLocalizations.supportedLocales
      .any((locale) => locale.languageCode == code);

  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale.languageCode) ||
        locale.languageCode == _locale.languageCode) {
      return;
    }
    _locale = Locale(locale.languageCode);
    notifyListeners();
    await _preferences.setString(inspectorLocaleKey, locale.languageCode);
  }
}
