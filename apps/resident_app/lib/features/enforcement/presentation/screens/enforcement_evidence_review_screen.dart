import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_location_map_preview.dart';
import '../../../../core/widgets/app_media_gallery.dart';
import '../../application/enforcement_controller.dart';
import '../../application/enforcement_report_draft.dart';

class EnforcementEvidenceReviewScreen extends ConsumerWidget {
  const EnforcementEvidenceReviewScreen({
    super.key,
    required this.draft,
  });

  final EnforcementReportDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reviewEvidence),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            draft.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(draft.description),
          const SizedBox(height: AppSpacing.md),
          AppLocationMapPreview(
            locationLabel: draft.locationLabel,
            latitude: draft.latitude,
            longitude: draft.longitude,
            geoMismatch: draft.geoMismatch,
          ),
          if (draft.hasMedia) ...[
            const SizedBox(height: AppSpacing.md),
            AppMediaGallery(attachments: draft.mediaAttachments),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${l10n.trustLevelLabel}: ${draft.geoMismatch ? l10n.lowGeoConfidence : l10n.standardTrust}',
          ),
          if (draft.geoMismatch) ...[
            const SizedBox(height: AppSpacing.md),
            AppInfoBanner(message: l10n.manualAddressRequiredNotice),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: () => _submit(context, ref),
            child: Text(l10n.submitReport),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    await ref.read(enforcementControllerProvider).createReport(
          title: draft.title,
          description: draft.description,
          locationLabel: draft.locationLabel,
          geoMismatch: draft.geoMismatch,
          latitude: draft.latitude,
          longitude: draft.longitude,
          mediaAttachments: draft.mediaAttachments,
        );

    if (!context.mounted) {
      return;
    }

    context.go('/enforcement');
  }
}
