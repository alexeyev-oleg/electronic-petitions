import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_location_map_preview.dart';
import '../../../../core/widgets/app_media_gallery.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../application/complaints_controller.dart';

class ComplaintDetailScreen extends ConsumerWidget {
  const ComplaintDetailScreen({
    super.key,
    required this.complaintId,
  });

  final String complaintId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(complaintsControllerProvider);
    final complaint = controller.findById(complaintId);

    if (complaint == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.complaints)),
        body: Center(child: Text(l10n.complaintNotFound)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.complaintDetail),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            complaint.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppStatusChip(status: complaint.status),
          const SizedBox(height: AppSpacing.md),
          Text(complaint.description),
          const SizedBox(height: AppSpacing.md),
          AppLocationMapPreview(
            locationLabel: complaint.locationLabel,
            latitude: complaint.latitude,
            longitude: complaint.longitude,
            geoMismatch: complaint.geoMismatch,
          ),
          if (complaint.hasMedia) ...[
            const SizedBox(height: AppSpacing.md),
            AppMediaGallery(attachments: complaint.mediaAttachments),
          ],
        ],
      ),
    );
  }
}
