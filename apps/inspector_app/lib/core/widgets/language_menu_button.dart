import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/localization/locale_controller.dart';

/// Language names are shown in their own script, never translated.
const _nativeLanguageNames = {
  'en': 'English',
  'he': 'עברית',
  'ru': 'Русский',
  'ar': 'العربية',
};

/// AppBar action that switches the app language. Stable keys for QA:
/// `language-selector` on the button, `lang-<code>` on each menu item.
class LanguageMenuButton extends ConsumerWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(localeControllerProvider);
    final current = controller.locale.languageCode;

    return PopupMenuButton<String>(
      key: const Key('language-selector'),
      icon: const Icon(Icons.language),
      tooltip: l10n.languageLabel,
      initialValue: current,
      onSelected: (code) => ref
          .read(localeControllerProvider.notifier)
          .setLocale(Locale(code)),
      itemBuilder: (context) => [
        for (final locale in AppLocalizations.supportedLocales)
          CheckedPopupMenuItem<String>(
            key: Key('lang-${locale.languageCode}'),
            value: locale.languageCode,
            checked: locale.languageCode == current,
            child: Text(
              _nativeLanguageNames[locale.languageCode] ??
                  locale.languageCode,
            ),
          ),
      ],
    );
  }
}
