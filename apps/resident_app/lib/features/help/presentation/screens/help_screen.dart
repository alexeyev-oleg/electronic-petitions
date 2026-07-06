import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_feature_tile.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.helpAndSupport),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppFeatureTile(
            title: l10n.helpFaq,
            icon: Icons.quiz_outlined,
            iconColor: AppColors.primary,
            onTap: () => context.push('/help/faq'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppFeatureTile(
            title: l10n.aboutApp,
            icon: Icons.info_outline,
            iconColor: AppColors.secondary,
            onTap: () => context.push('/help/about'),
          ),
        ],
      ),
    );
  }
}
