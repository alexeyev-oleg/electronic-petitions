import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_brand_header.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_section_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aboutApp),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppSectionCard(
            child: Column(
              children: [
                AppBrandHeader(
                  title: l10n.appTitle,
                  compact: true,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.aboutDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '${l10n.appVersionLabel}: 0.1.0+1',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppInfoBanner(message: l10n.mockModeNotice),
        ],
      ),
    );
  }
}
