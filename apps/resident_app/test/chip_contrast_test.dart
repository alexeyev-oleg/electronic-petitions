// QA regression for stage 1.3: chip labels in the resident app are readable.
//
// Screen-level test: the real PetitionsListScreen / PetitionDetailScreen with the real
// theme (AppTheme.build) and the bundled mock seed. Colours are measured from the
// rendered frame, not from the theme, so translucent fills (selected = terracotta at
// low alpha) are already blended with the surface underneath. The label colour is the
// rendered ink inside the label box that contrasts most with the chip background
// (the test font draws glyphs as boxes/outlines); an invisible label therefore
// measures 1:1 and fails.
//
// Requirement (WCAG AA, normal text): label vs chip background contrast >= 4.5:1,
// for selected and unselected chips, in every UI language.
import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resident_app/app/localization/app_localizations.dart';
import 'package:resident_app/app/theme/app_theme.dart';
import 'package:resident_app/core/widgets/app_status_chip.dart';
import 'package:resident_app/features/petitions/application/petitions_controller.dart';
import 'package:resident_app/features/petitions/presentation/screens/petition_detail_screen.dart';
import 'package:resident_app/features/petitions/presentation/screens/petitions_list_screen.dart';
import 'package:resident_app/shared/repositories/preferences_repository_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _minContrast = 4.5;

/// Status chips: pale text is a known stage 3 item (lead, 2026-11-18). TODO(stage 3): use _minContrast.
const _statusMinContrastUntilStage3 = 1.5;
const _locales = ['ru', 'en', 'he', 'ar'];
final _boundaryKey = GlobalKey();

String _signedLabel(String code) => AppLocalizations(Locale(code)).petitionSignedLabel;

double _luminance(Color c) {
  double ch(double v) => v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * ch(c.r) + 0.7152 * ch(c.g) + 0.0722 * ch(c.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a), lb = _luminance(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

String _hex(Color c) => '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

/// [logicalWidth]: the filter row is a lazy horizontal list; at phone width only the first
/// chips are built, so the filter test uses a wider view to get all four (colours do not
/// depend on width).
Future<void> _pump(WidgetTester tester, Widget screen, String locale, {SharedPreferences? prefs, double logicalWidth = 360}) async {
  tester.view.physicalSize = Size(logicalWidth * 3, 2340);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  if (prefs == null) {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  }
  await tester.pumpWidget(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: RepaintBoundary(
        key: _boundaryKey,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.build(),
          locale: Locale(locale),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: screen,
        ),
      ),
    ),
  );
  await _settle(tester);
}

/// Seed loading is real async I/O (rootBundle + prefs) and shows an endless spinner,
/// so pumpAndSettle alone would never return. Wait (bounded) until the spinner is gone.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 100; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
    await tester.pump(const Duration(milliseconds: 50));
    if (i > 3 && find.byType(CircularProgressIndicator).evaluate().isEmpty) break;
  }
  expect(find.byType(CircularProgressIndicator), findsNothing, reason: 'mock data loaded');
  await tester.pumpAndSettle(const Duration(milliseconds: 100), EnginePhase.sendSemanticsUpdate, const Duration(seconds: 10));
}

const _scale = 3.0;

class _Frame {
  _Frame(this.bytes, this.width);
  final ByteData bytes;
  final int width;

  Color _px(int x, int y) {
    final i = (y * width + x) * 4;
    return Color.fromARGB(255, bytes.getUint8(i), bytes.getUint8(i + 1), bytes.getUint8(i + 2));
  }

  /// Pixel at a logical position.
  Color at(Offset p) => _px((p.dx * _scale).round(), (p.dy * _scale).round());

  /// Rendered colour inside [r] (logical) that contrasts most with [background].
  Color strongestInk(Rect r, Color background) {
    var best = background;
    var bestRatio = 1.0;
    for (var y = (r.top * _scale).ceil(); y < (r.bottom * _scale).floor(); y++) {
      for (var x = (r.left * _scale).ceil(); x < (r.right * _scale).floor(); x++) {
        final c = _px(x, y);
        final ratio = _contrast(c, background);
        if (ratio > bestRatio) {
          bestRatio = ratio;
          best = c;
        }
      }
    }
    return best;
  }
}

Future<_Frame> _capture(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(_boundaryKey));
  final frame = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: _scale);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final f = _Frame(data!, image.width);
    image.dispose();
    return f;
  });
  return frame!;
}

class _Measurement {
  _Measurement(this.name, this.label, this.background);
  final String name;
  final Color label;
  final Color background;
  double get ratio => _contrast(label, background);
  @override
  String toString() => '$name: label ${_hex(label)} on ${_hex(background)} = ${ratio.toStringAsFixed(2)}:1';
}

/// Background = just past the label's trailing edge; label = strongest ink inside the label box.
_Measurement _measure(WidgetTester tester, _Frame frame, Finder chip, String name) {
  final chipRect = tester.getRect(chip);
  final text = find.descendant(of: chip, matching: find.byType(RichText)).first;
  final textRect = tester.getRect(text);
  final rtl = Directionality.of(tester.element(chip)) == TextDirection.rtl;
  // 2 logical px past the label's trailing edge: inside the chip's label padding,
  // never outside the visual pill (the hit-test rect can be larger than the pill).
  final pad = Offset(rtl ? textRect.left - 2 : textRect.right + 2, textRect.center.dy);
  expect(chipRect.contains(pad), isTrue, reason: '$name: background sample inside chip');
  final background = frame.at(pad);
  return _Measurement(name, frame.strongestInk(textRect, background), background);
}

void _expectReadable(List<_Measurement> ms) {
  for (final m in ms) {
    expect(m.ratio, greaterThanOrEqualTo(_minContrast), reason: '$m');
  }
}

void main() {
  // rootBundle caches asset futures across tests; a future from a finished test's
  // fake-async zone never completes in the next one.
  setUp(() => rootBundle.clear());

  for (final locale in _locales) {
    group('petitions filters ($locale)', () {
      testWidgets('selected and unselected filter chips have readable labels', (tester) async {
        await _pump(tester, const PetitionsListScreen(), locale, logicalWidth: 800);
        final chips = find.byType(FilterChip);
        expect(chips, findsNWidgets(4), reason: 'All / Published / In review / Draft');

        var frame = await _capture(tester);
        final measured = <_Measurement>[];
        for (var i = 0; i < 4; i++) {
          final chip = chips.at(i);
          final w = tester.widget<FilterChip>(chip);
          expect(find.descendant(of: chip, matching: find.byType(RichText)), findsWidgets, reason: 'label text present');
          measured.add(_measure(tester, frame, chip, 'filter #$i ${w.selected ? 'selected' : 'unselected'}'));
        }
        expect(measured.where((m) => m.name.contains(' selected')).length, 1, reason: 'one filter selected by default');

        // Select another filter and measure again: both states on every position.
        await tester.tap(chips.at(1));
        await tester.pumpAndSettle();
        frame = await _capture(tester);
        for (var i = 0; i < 4; i++) {
          final w = tester.widget<FilterChip>(chips.at(i));
          measured.add(_measure(tester, frame, chips.at(i), 'after tap: filter #$i ${w.selected ? 'selected' : 'unselected'}'));
        }
        // ignore: avoid_print
        print('[$locale]\n  ${measured.join('\n  ')}');
        _expectReadable(measured);

        // Selected and unselected must still look different.
        final sel = measured.firstWhere((m) => m.name.contains(' selected')).background;
        final unsel = measured.firstWhere((m) => m.name.contains('unselected')).background;
        expect(sel, isNot(equals(unsel)), reason: 'selected chip background differs from unselected');
      });
    });

    testWidgets('petition detail: "signed" chip and status chip readable ($locale)', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await _pump(tester, const PetitionDetailScreen(petitionId: 'p2'), locale, prefs: prefs);
      // Detail has no spinner: wait until the seed is actually written to the mock store.
      for (var i = 0; i < 100 && prefs.getString('mock_petitions_v2') == null; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(prefs.getString('mock_petitions_v2'), isNotNull, reason: 'mock petitions seeded');
      // Mark p2 as signed in the mock store (same as a completed signature) and reload.
      final stored = jsonDecode(prefs.getString('mock_petitions_v2')!) as List<dynamic>;
      for (final p in stored.cast<Map<String, dynamic>>()) {
        if (p['id'] == 'p2') p['signedByCurrentUser'] = true;
      }
      await prefs.setString('mock_petitions_v2', jsonEncode(stored));
      ProviderScope.containerOf(tester.element(find.byType(PetitionDetailScreen))).invalidate(petitionsControllerProvider);
      for (var i = 0; i < 100 && find.byType(Chip).evaluate().length < 2; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
        await tester.pump(const Duration(milliseconds: 50));
      }
      await _settle(tester);

      final statusChip = find.descendant(of: find.byType(AppStatusChip), matching: find.byType(Chip));
      final signedChip = find.ancestor(of: find.text(_signedLabel(locale)), matching: find.byType(Chip));
      expect(statusChip, findsOneWidget, reason: 'status chip');
      expect(signedChip, findsOneWidget, reason: '"signed" chip with its localized label');
      final frame = await _capture(tester);
      final signed = _measure(tester, frame, signedChip, 'signed chip');
      final status = _measure(tester, frame, statusChip, 'status chip (moderation_review)');
      // ignore: avoid_print
      print('[$locale detail]\n  $signed\n  $status');
      _expectReadable([signed]);
      // Known, out of stage 1 scope: pale status colours are a stage 3 token decision.
      // Guard only against invisibility for now; raise to _minContrast in stage 3.
      expect(status.ratio, greaterThanOrEqualTo(_statusMinContrastUntilStage3), reason: '$status');
    });
  }
}
