import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';
import '../models/petition_attachment.dart';

class AppPetitionAttachmentGallery extends StatelessWidget {
  const AppPetitionAttachmentGallery({
    super.key,
    required this.attachments,
  });

  final List<PetitionAttachment> attachments;

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    final photos =
        attachments.where((item) => item.kind == PetitionAttachmentKind.photo);
    final documents =
        attachments.where((item) => item.kind != PetitionAttachmentKind.photo);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.petitionAttachmentsTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (photos.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.petitionAttachmentPhotosLabel,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 112,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                return _PhotoTile(attachment: photos.elementAt(index));
              },
            ),
          ),
        ],
        if (documents.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.petitionAttachmentDocumentsLabel,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          ...documents.map(
            (attachment) => _DocumentTile(attachment: attachment),
          ),
        ],
      ],
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.attachment});

  final PetitionAttachment attachment;

  @override
  Widget build(BuildContext context) {
    if (attachment.path.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          attachment.path,
          width: 112,
          height: 112,
          fit: BoxFit.cover,
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
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 32),
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
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({required this.attachment});

  final PetitionAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(_iconForKind(attachment.kind)),
        title: Text(attachment.displayName),
        subtitle: Text(_labelForKind(context, attachment.kind)),
      ),
    );
  }

  String _labelForKind(BuildContext context, PetitionAttachmentKind kind) {
    final l10n = AppLocalizations.of(context);
    switch (kind) {
      case PetitionAttachmentKind.photo:
        return l10n.petitionAttachmentPhotosLabel;
      case PetitionAttachmentKind.pdf:
        return l10n.petitionAttachmentTypePdf;
      case PetitionAttachmentKind.doc:
        return l10n.petitionAttachmentTypeDoc;
      case PetitionAttachmentKind.excel:
        return l10n.petitionAttachmentTypeExcel;
    }
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
