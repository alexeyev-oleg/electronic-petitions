// QA regression for stage 1.4: the inspector app speaks en/he/ru/ar.
//
// - first launch follows the device language (Android "iw" = Hebrew), else English;
// - the language menu (Key('language-selector'), Key('lang-<code>')) switches the UI;
// - he/ar render right-to-left, en/ru left-to-right;
// - the choice survives an app restart.
//
// Deliberately uses only the public app surface (InspectorApp, LoginScreen,
// AppLocalizations, the SharedPreferences key) so the same file also runs
// against older revisions and fails there instead of not compiling.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspector_app/app/app.dart';
import 'package:inspector_app/app/localization/app_localizations.dart';
import 'package:inspector_app/features/auth/presentation/screens/login_screen.dart';
import 'package:inspector_app/shared/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _codes = ['en', 'he', 'ru', 'ar'];
const _rtl = {'he', 'ar'};
const _prefsKey = 'inspector_locale_code';

/// Expected login title for a language, taken from the app's own string table.
String _signIn(String code) => AppLocalizations(Locale(code)).signIn;

/// Starts the app the way bootstrap does and waits until the login screen is shown.
Future<void> _launch(WidgetTester tester, SharedPreferences prefs) async {
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(), // a new scope = a cold app start
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const InspectorApp(),
    ),
  );
  // Splash waits for the mock auth store (real async I/O) plus a fixed delay.
  for (var i = 0; i < 20 && find.byType(LoginScreen).evaluate().isEmpty; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(milliseconds: 250));
  }
  await tester.pumpAndSettle();
  expect(find.byType(LoginScreen), findsOneWidget, reason: 'login screen reached after splash');
}

Future<SharedPreferences> _prefs([Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  return SharedPreferences.getInstance();
}

void _setDevice(WidgetTester tester, List<Locale> locales) {
  tester.platformDispatcher.localesTestValue = locales;
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
}

String _appBarTitle(WidgetTester tester) {
  final title = tester.widget<AppBar>(find.byType(AppBar)).title;
  return title is Text ? (title.data ?? '') : '';
}

void _expectLanguage(WidgetTester tester, String code) {
  final login = tester.element(find.byType(LoginScreen));
  expect(Localizations.localeOf(login).languageCode, code, reason: 'active locale');
  expect(_appBarTitle(tester), _signIn(code), reason: 'login title is the $code translation');
  expect(
    Directionality.of(login),
    _rtl.contains(code) ? TextDirection.rtl : TextDirection.ltr,
    reason: 'text direction for $code',
  );
}

Future<void> _choose(WidgetTester tester, String code) async {
  await tester.tap(find.byKey(const Key('language-selector')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key('lang-$code')));
  await tester.pumpAndSettle();
}

void main() {
  test('every language has its own login title (no silent English fallback)', () {
    final titles = {for (final c in _codes) c: _signIn(c)};
    expect(titles.values.toSet().length, _codes.length, reason: '$titles');
  });

  group('first launch follows the device language', () {
    final cases = <String, (List<Locale>, String)>{
      'Hebrew device reported as iw_IL': (const [Locale('iw', 'IL')], 'he'),
      'Hebrew device reported as he_IL': (const [Locale('he', 'IL')], 'he'),
      'Arabic device': (const [Locale('ar', 'IL')], 'ar'),
      'Russian device': (const [Locale('ru', 'RU')], 'ru'),
      'unsupported device language falls back to English': (const [Locale('fr', 'FR')], 'en'),
      'first supported language in the device list wins': (const [Locale('fr'), Locale('ar')], 'ar'),
    };
    cases.forEach((name, c) {
      testWidgets(name, (tester) async {
        _setDevice(tester, c.$1);
        await _launch(tester, await _prefs());
        _expectLanguage(tester, c.$2);
      });
    });
  });

  testWidgets('language menu lists all four languages in their own script', (tester) async {
    _setDevice(tester, const [Locale('en', 'US')]);
    await _launch(tester, await _prefs());
    expect(find.byKey(const Key('language-selector')), findsOneWidget, reason: 'selector on login screen');
    await tester.tap(find.byKey(const Key('language-selector')));
    await tester.pumpAndSettle();
    const names = {'en': 'English', 'he': 'עברית', 'ru': 'Русский', 'ar': 'العربية'};
    for (final code in _codes) {
      final item = find.byKey(Key('lang-$code'));
      expect(item, findsOneWidget, reason: 'menu item lang-$code');
      expect(find.descendant(of: item, matching: find.text(names[code]!)), findsOneWidget,
          reason: 'lang-$code shows "${names[code]}"');
    }
  });

  testWidgets('switching he → ru → ar → en changes texts, direction and the saved choice', (tester) async {
    _setDevice(tester, const [Locale('en', 'US')]);
    final prefs = await _prefs();
    await _launch(tester, prefs);
    _expectLanguage(tester, 'en');

    for (final code in ['he', 'ru', 'ar', 'en']) {
      await _choose(tester, code);
      _expectLanguage(tester, code);
      expect(prefs.getString(_prefsKey), code, reason: 'choice stored under $_prefsKey');
    }
  });

  for (final code in ['he', 'ru', 'ar']) {
    testWidgets('chosen $code survives a restart (device stays English)', (tester) async {
      _setDevice(tester, const [Locale('en', 'US')]);
      final prefs = await _prefs();
      await _launch(tester, prefs);
      await _choose(tester, code);
      _expectLanguage(tester, code);

      await _launch(tester, prefs); // cold start, same storage
      _expectLanguage(tester, code);
    });
  }

  testWidgets('saved choice beats the device language', (tester) async {
    _setDevice(tester, const [Locale('iw', 'IL')]);
    await _launch(tester, await _prefs({_prefsKey: 'ru'}));
    _expectLanguage(tester, 'ru');
  });
}
