import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/gesher_brand_mark.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final items = [
      _HelpItem(l10n.faqQuestionOtp, l10n.faqAnswerOtp),
      _HelpItem(l10n.faqQuestionTriage, l10n.faqAnswerTriage),
      _HelpItem(l10n.faqQuestionDispatch, l10n.faqAnswerDispatch),
      _HelpItem(l10n.faqQuestionSync, l10n.faqAnswerSync),
      _HelpItem(l10n.faqQuestionIds, l10n.faqAnswerIds),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.helpTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Center(
            child: GesherBrandMark(
              size: 64,
              tagline: l10n.inspectorAppBadge,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.demoSyncHint,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          ...items.map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ExpansionTile(
                title: Text(
                  item.question,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(item.answer),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _HelpItem {
  const _HelpItem(this.question, this.answer);

  final String question;
  final String answer;
}
