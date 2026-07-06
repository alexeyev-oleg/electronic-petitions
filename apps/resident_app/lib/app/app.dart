import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/profile/application/preferences_controller.dart';
import 'environment/app_environment.dart';
import 'localization/app_localizations.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class ResidentApp extends ConsumerWidget {
  const ResidentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment = ref.watch(appEnvironmentProvider);
    final router = ref.watch(appRouterProvider);
    final preferences = ref.watch(preferencesControllerProvider);

    return MaterialApp.router(
      title: 'Resident App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      routerConfig: router,
      locale: preferences.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final content = child ?? const SizedBox.shrink();
        if (!environment.isBetaLike) {
          return content;
        }

        final locale = preferences.locale;
        final textDirection = locale.languageCode == 'he' ||
                locale.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr;

        return Directionality(
          textDirection: textDirection,
          child: Banner(
            message: environment.displayName,
            location: BannerLocation.topEnd,
            child: content,
          ),
        );
      },
    );
  }
}
