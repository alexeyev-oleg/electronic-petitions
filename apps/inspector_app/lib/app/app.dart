import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'environment/app_environment.dart';
import 'localization/app_localizations.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class InspectorApp extends ConsumerWidget {
  const InspectorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment = ref.watch(appEnvironmentProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'G.E.S.H.E.R. Inspector',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      routerConfig: router,
      locale: const Locale('en'),
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

        return Banner(
          message: environment.displayName,
          location: BannerLocation.topEnd,
          child: content,
        );
      },
    );
  }
}
