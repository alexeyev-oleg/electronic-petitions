import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';
import '../models/petition_attachment.dart';

class AppPetitionAttachmentEditor extends StatelessWidget {
  const AppPetitionAttachmentEditor({
    super.key,
    required this.attachments,
    required this.canAddMore,
    required this.onPickPhotoCamera,
    required this.onPickPhotoGallery,
    required this.onPickFile,
    required this.onRemove,
  });

  final List<PetitionAttachment> attachments;
  final bool canAddMore;
  final VoidCallback onPickPhotoCamera;
  final VoidCallback onPickPhotoGallery;
  final VoidCallback onPickFile;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.petitionAttachmentsTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.petitionAttachmentsHelp,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.petitionAttachmentCount(
            attachments.length,
            petitionMaxAttachments,
          ),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            OutlinedButton.icon(
              onPressed: canAddMore ? onPickPhotoCamera : null,
              icon: const Icon(Icons.photo_camera),
              label: Text(l10n.takePhoto),
            ),
            OutlinedButton.icon(
              onPressed: canAddMore ? onPickPhotoGallery : null,
              icon: const Icon(Icons.photo_library),
              label: Text(l10n.pickFromGallery),
            ),
            OutlinedButton.icon(
              onPressed: canAddMore ? onPickFile : null,
              icon: const Icon(Icons.attach_file),
              label: Text(l10n.attachPetitionFile),
            ),
          ],
        ),
        if (attachments.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: attachments.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final attachment = attachments[index];
                return Stack(
                  children: [
                    _AttachmentPreview(attachment: attachment),
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

class _AttachmentPreview extends StatelessWidget {
  const _AttachmentPreview({required this.attachment});

  final PetitionAttachment attachment;

  @override
  Widget build(BuildContext context) {
    if (attachment.isPhoto) {
      final file = File(attachment.path);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            file,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        );
      }
    }

    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _iconForKind(attachment.kind),
            size: 32,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            attachment.displayName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  IconData _iconForKind(PetitionAttachmentKind kind) {
    switch (kind) {
      case PetitionAttachmentKind.photo:
        return Icons.image_outlined;
      case PetitionAttachmentKind.pdf:
        return Icons.picture_as_pdf_outlined;
      case PetitionAttachmentKind.doc:
        return Icons.description_outlined;
      case PetitionAttachmentKind.excel:
        return Icons.table_chart_outlined;
    }
  }
}
