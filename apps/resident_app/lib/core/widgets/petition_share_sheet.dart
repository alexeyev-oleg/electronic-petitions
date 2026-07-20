import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';
import '../services/petition_share_service.dart';

abstract final class PetitionShareSheet {
  static Future<void> show(
    BuildContext context, {
    required String petitionId,
    required String title,
  }) {
    final l10n = AppLocalizations.of(context);

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.sharePetitionTitle,
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: Text(l10n.shareViaEmail),
                  onTap: () => _share(
                    sheetContext,
                    channel: PetitionShareChannel.email,
                    title: title,
                    petitionId: petitionId,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.chat_outlined),
                  title: Text(l10n.shareViaWhatsApp),
                  onTap: () => _share(
                    sheetContext,
                    channel: PetitionShareChannel.whatsapp,
                    title: title,
                    petitionId: petitionId,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.send_outlined),
                  title: Text(l10n.shareViaTelegram),
                  onTap: () => _share(
                    sheetContext,
                    channel: PetitionShareChannel.telegram,
                    title: title,
                    petitionId: petitionId,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> _share(
    BuildContext context, {
    required PetitionShareChannel channel,
    required String title,
    required String petitionId,
  }) async {
    final l10n = AppLocalizations.of(context);
    Navigator.of(context).pop();
    final launched = await PetitionShareService.share(
      channel: channel,
      title: title,
      petitionId: petitionId,
    );
    if (!context.mounted || launched) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.sharePetitionFailed)),
    );
  }
}
