import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/gesher_brand_mark.dart';
import '../../../auth/application/auth_controller.dart';

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
    await Future.wait([
      ref.read(authControllerProvider.notifier).ensureInitialized(),
      Future<void>.delayed(const Duration(milliseconds: 900)),
    ]);

    if (!mounted) {
      return;
    }

    final auth = ref.read(authControllerProvider);
    context.go(auth.isAuthenticated ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.graphite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GesherBrandMark(
                size: 96,
                inverted: true,
                badge: l10n.inspectorAppBadge,
                tagline: l10n.brandTagline,
              ),
              const SizedBox(height: AppSpacing.xl),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
