import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_petition_attachment_gallery.dart';
import '../../../../core/widgets/app_sensitive_action_sheet.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../../auth/application/auth_controller.dart';
import '../../application/petitions_controller.dart';

class PetitionDetailScreen extends ConsumerStatefulWidget {
  const PetitionDetailScreen({
    super.key,
    required this.petitionId,
  });

  final String petitionId;

  @override
  ConsumerState<PetitionDetailScreen> createState() =>
      _PetitionDetailScreenState();
}

class _PetitionDetailScreenState extends ConsumerState<PetitionDetailScreen> {
  var _hasSignedLocally = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(petitionsControllerProvider);
    final auth = ref.watch(authControllerProvider);
    final user = auth.currentUser;
    final petition = controller.findById(widget.petitionId);

    if (petition == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.petitions)),
        body: Center(child: Text(l10n.petitionNotFound)),
      );
    }

    final canSign = user?.canSignPetitions == true && !_hasSignedLocally;

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
          const SizedBox(height: AppSpacing.md),
          Text(petition.summary),
          if (petition.attachments.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            AppPetitionAttachmentGallery(attachments: petition.attachments),
          ],
          const SizedBox(height: AppSpacing.md),
          Text('${l10n.signatureCountLabel}: ${petition.signatureCount}'),
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
          FilledButton(
            onPressed: canSign ? () => _signPetition(context) : null,
            child: Text(
              canSign ? l10n.signPetitionAction : l10n.betaSignaturePlaceholder,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signPetition(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await AppSensitiveActionSheet.show(
      context,
      ref: ref,
      title: l10n.sensitiveActionTitle,
      message: l10n.sensitiveActionMessage,
    );
    if (!confirmed || !mounted) return;

    final updated = await ref
        .read(petitionsControllerProvider)
        .signPetition(widget.petitionId);
    if (!mounted) return;

    if (updated == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.loadErrorMessage)),
      );
      return;
    }

    setState(() => _hasSignedLocally = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.petitionSignedNotice)),
    );
  }
}
