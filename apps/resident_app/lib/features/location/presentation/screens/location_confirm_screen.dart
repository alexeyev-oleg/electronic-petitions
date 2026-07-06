import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/models/location_confirm_payload.dart';
import '../../../../core/widgets/app_location_map_preview.dart';

class LocationConfirmScreen extends StatelessWidget {
  const LocationConfirmScreen({
    super.key,
    required this.payload,
  });

  final LocationConfirmPayload payload;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.confirmLocationTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.confirmLocationHelp,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          AppLocationMapPreview(
            locationLabel: payload.locationLabel,
            latitude: payload.latitude,
            longitude: payload.longitude,
            geoMismatch: payload.geoMismatch,
          ),
          if (payload.geoMismatch) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.manualAddressRequiredNotice,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: () => context.pop(true),
            child: Text(l10n.confirmLocationAction),
          ),
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(l10n.editLocationAction),
          ),
        ],
      ),
    );
  }
}
