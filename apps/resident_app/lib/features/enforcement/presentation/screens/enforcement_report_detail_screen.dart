import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_location_map_preview.dart';
import '../../../../core/widgets/app_media_gallery.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../application/enforcement_controller.dart';

class EnforcementReportDetailScreen extends ConsumerWidget {
  const EnforcementReportDetailScreen({
    super.key,
    required this.reportId,
  });

  final String reportId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(enforcementControllerProvider);
    final report = controller.findById(reportId);

    if (report == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.enforcement)),
        body: Center(child: Text(l10n.enforcementReportNotFound)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.enforcementReportDetail),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            report.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppStatusChip(status: report.status),
          const SizedBox(height: AppSpacing.md),
          Text(report.description),
          const SizedBox(height: AppSpacing.md),
          AppLocationMapPreview(
            locationLabel: report.locationLabel,
            latitude: report.latitude,
            longitude: report.longitude,
            geoMismatch: report.geoMismatch,
          ),
          if (report.hasMedia) ...[
            const SizedBox(height: AppSpacing.md),
            AppMediaGallery(attachments: report.mediaAttachments),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text('${l10n.trustLevelLabel}: ${report.trustLabel}'),
          if (report.geoMismatch) ...[
            const SizedBox(height: AppSpacing.md),
            AppInfoBanner(message: l10n.manualAddressRequiredNotice),
          ],
        ],
      ),
    );
  }
}
