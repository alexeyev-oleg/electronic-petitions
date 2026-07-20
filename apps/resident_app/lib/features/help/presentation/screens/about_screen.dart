import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_build_info.dart';
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
                  subtitle: l10n.brandTagline,
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
                  '${l10n.appVersionLabel}: $kAppVersionFull ($kMockReleaseLabel · seed $kMockSeedVersion)',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
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
