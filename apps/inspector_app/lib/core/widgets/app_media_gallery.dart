import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../models/media_attachment.dart';

class AppMediaGallery extends StatelessWidget {
  const AppMediaGallery({
    super.key,
    required this.attachments,
  });

  final List<MediaAttachment> attachments;

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.evidenceSectionTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 112,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: attachments.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              return _MediaTile(attachment: attachments[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _MediaTile extends StatelessWidget {
  const _MediaTile({required this.attachment});

  final MediaAttachment attachment;

  @override
  Widget build(BuildContext context) {
    if (attachment.isVideo) {
      return Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outline),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam_outlined, size: 36),
            const SizedBox(height: AppSpacing.xs),
            Text(AppLocalizations.of(context).videoLabel),
          ],
        ),
      );
    }

    final file = File(attachment.path);
    if (file.existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          file,
          width: 112,
          height: 112,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
      ),
      child: const Icon(Icons.image_outlined, size: 36),
    );
  }
}
