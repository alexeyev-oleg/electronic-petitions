import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/gesher_brand_mark.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../profile/application/preferences_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await Future.wait([
        ref.read(preferencesControllerProvider.notifier).ensureInitialized(),
        ref.read(authControllerProvider.notifier).ensureInitialized(),
        Future<void>.delayed(const Duration(milliseconds: 1200)),
      ]).timeout(const Duration(seconds: 8));
    } catch (error, stackTrace) {
      debugPrint('splash bootstrap failed: $error\n$stackTrace');
    }

    if (!mounted) return;

    final preferences = ref.read(preferencesControllerProvider);
    if (!preferences.onboardingCompleted) {
      context.go('/onboarding');
      return;
    }

    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.graphite,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GesherBrandMark(
                  size: 96,
                  inverted: true,
                  tagline: l10n.brandTagline,
                ),
                const SizedBox(height: AppSpacing.xl),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
