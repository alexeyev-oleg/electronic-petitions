import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';
import '../models/media_attachment.dart';

class AppMediaAttachmentEditor extends StatelessWidget {
  const AppMediaAttachmentEditor({
    super.key,
    required this.attachments,
    required this.onPickPhotoCamera,
    required this.onPickPhotoGallery,
    required this.onPickVideoCamera,
    required this.onPickVideoGallery,
    required this.onRemove,
  });

  final List<MediaAttachment> attachments;
  final VoidCallback onPickPhotoCamera;
  final VoidCallback onPickPhotoGallery;
  final VoidCallback onPickVideoCamera;
  final VoidCallback onPickVideoGallery;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.attachMedia,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            OutlinedButton.icon(
              onPressed: onPickPhotoCamera,
              icon: const Icon(Icons.photo_camera),
              label: Text(l10n.takePhoto),
            ),
            OutlinedButton.icon(
              onPressed: onPickPhotoGallery,
              icon: const Icon(Icons.photo_library),
              label: Text(l10n.pickFromGallery),
            ),
            OutlinedButton.icon(
              onPressed: onPickVideoCamera,
              icon: const Icon(Icons.videocam_outlined),
              label: Text(l10n.takeVideo),
            ),
            OutlinedButton.icon(
              onPressed: onPickVideoGallery,
              icon: const Icon(Icons.video_library_outlined),
              label: Text(l10n.pickVideoFromGallery),
            ),
          ],
        ),
        if (attachments.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text('${l10n.attachedMediaCount}: ${attachments.length}'),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 112,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: attachments.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final attachment = attachments[index];
                return Stack(
                  children: [
                    attachment.isVideo
                        ? Container(
                            width: 112,
                            height: 112,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            child: const Icon(Icons.videocam_outlined, size: 36),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(attachment.path),
                              width: 112,
                              height: 112,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.errorContainer,
                        ),
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () => onRemove(index),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
