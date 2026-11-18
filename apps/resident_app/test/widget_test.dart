import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:resident_app/app/app.dart';
import 'package:resident_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:resident_app/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:resident_app/shared/repositories/preferences_repository_provider.dart';

void main() {
  testWidgets('app starts on splash and opens onboarding on first launch',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
        ],
        child: const ResidentApp(),
      ),
    );

    // Localizations load asynchronously; the first frame is empty.
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);

    // Splash waits at least 1200 ms (fake clock) and loads the mock seed from
    // assets (real I/O), so alternate real waits with fake-time pumps.
    for (var i = 0; i < 10 && find.byType(OnboardingScreen).evaluate().isEmpty;
        i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump(const Duration(milliseconds: 300));
    }

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
