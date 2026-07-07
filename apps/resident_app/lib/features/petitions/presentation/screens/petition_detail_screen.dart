import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_petition_attachment_gallery.dart';
import '../../../../core/widgets/app_sensitive_action_sheet.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../../auth/application/auth_controller.dart';
import '../../application/petitions_controller.dart';

class PetitionDetailScreen extends ConsumerWidget {
  const PetitionDetailScreen({
    super.key,
    required this.petitionId,
  });

  final String petitionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(petitionsControllerProvider);
    final auth = ref.watch(authControllerProvider);
    final user = auth.currentUser;
    final petition = controller.findById(petitionId);

    if (petition == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.petitions)),
        body: Center(child: Text(l10n.petitionNotFound)),
      );
    }

    final canSign =
        user?.canSignPetitions == true && !petition.signedByCurrentUser;
    final progress = petition.signatureProgress;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.petitionDetail),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            petition.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppStatusChip(status: petition.status),
          if (petition.signedByCurrentUser) ...[
            const SizedBox(height: AppSpacing.sm),
            Chip(
              avatar: const Icon(Icons.check_circle_outline, size: 18),
              label: Text(l10n.petitionSignedLabel),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(petition.summary),
          if (petition.attachments.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            AppPetitionAttachmentGallery(attachments: petition.attachments),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.signatureCountLabel}: ${petition.signatureCount} / ${petition.signatureGoal}',
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.outline,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${(progress * 100).round()}%',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (user != null && !user.canSignPetitions) ...[
            const SizedBox(height: AppSpacing.md),
            AppInfoBanner(message: l10n.kycRequiredBanner),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => context.push('/auth/kyc'),
              child: Text(l10n.startKycAction),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            button: true,
            label: canSign ? l10n.signPetitionAction : l10n.betaSignaturePlaceholder,
            enabled: canSign,
            child: FilledButton(
              onPressed: canSign
                  ? () => _signPetition(context, ref, petitionId)
                  : null,
              child: Text(
                petition.signedByCurrentUser
                    ? l10n.petitionSignedLabel
                    : canSign
                        ? l10n.signPetitionAction
                        : l10n.betaSignaturePlaceholder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signPetition(
    BuildContext context,
    WidgetRef ref,
    String petitionId,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await AppSensitiveActionSheet.show(
      context,
      ref: ref,
      title: l10n.sensitiveActionTitle,
      message: l10n.sensitiveActionMessage,
    );
    if (!confirmed || !context.mounted) return;

    final updated = await ref
        .read(petitionsControllerProvider)
        .signPetition(petitionId);
    if (!context.mounted) return;

    if (updated == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.loadErrorMessage)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.petitionSignedNotice)),
    );
  }
}
