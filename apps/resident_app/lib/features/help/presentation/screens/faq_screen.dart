import 'package:flutter/material.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_section_card.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final items = [
      _FaqItem(l10n.faqQuestionBeta, l10n.faqAnswerBeta),
      _FaqItem(l10n.faqQuestionLanguage, l10n.faqAnswerLanguage),
      _FaqItem(l10n.faqQuestionSecureAuth, l10n.faqAnswerSecureAuth),
      _FaqItem(l10n.faqQuestionMockOtp, l10n.faqAnswerMockOtp),
      _FaqItem(l10n.faqQuestionLocation, l10n.faqAnswerLocation),
      _FaqItem(l10n.faqQuestionMedia, l10n.faqAnswerMedia),
      _FaqItem(l10n.faqQuestionPendingStatus, l10n.faqAnswerPendingStatus),
      _FaqItem(l10n.faqQuestionPetitions, l10n.faqAnswerPetitions),
      _FaqItem(l10n.faqQuestionComplaints, l10n.faqAnswerComplaints),
      _FaqItem(l10n.faqQuestionNotifications, l10n.faqAnswerNotifications),
      _FaqItem(l10n.faqQuestionMockSync, l10n.faqAnswerMockSync),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.helpFaq),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final item = items[index];
          return AppSectionCard(
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: Text(
                item.question,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    item.answer,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FaqItem {
  const _FaqItem(this.question, this.answer);

  final String question;
  final String answer;
}
