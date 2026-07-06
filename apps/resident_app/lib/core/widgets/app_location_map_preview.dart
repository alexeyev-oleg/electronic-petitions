import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class AppLocationMapPreview extends StatelessWidget {
  const AppLocationMapPreview({
    super.key,
    required this.locationLabel,
    this.latitude,
    this.longitude,
    this.geoMismatch = false,
  });

  final String locationLabel;
  final double? latitude;
  final double? longitude;
  final bool geoMismatch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.12),
                  AppColors.secondary.withValues(alpha: 0.10),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  size: 72,
                  color: AppColors.primary.withValues(alpha: 0.35),
                ),
                Icon(
                  Icons.location_on,
                  size: 42,
                  color: geoMismatch
                      ? AppColors.statusWarning
                      : AppColors.primary,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.locationLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  locationLabel,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (latitude != null && longitude != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${l10n.deviceCoordinates}: ${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                if (geoMismatch) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.geoMismatchDetected,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.statusWarning,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
