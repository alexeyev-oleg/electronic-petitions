import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/models/petition_attachment.dart';
import '../../../../core/services/petition_attachment_picker_service.dart';
import '../../../../core/widgets/app_petition_attachment_editor.dart';
import '../../application/petitions_controller.dart';

class PetitionCreateScreen extends ConsumerStatefulWidget {
  const PetitionCreateScreen({super.key});

  @override
  ConsumerState<PetitionCreateScreen> createState() =>
      _PetitionCreateScreenState();
}

class _PetitionCreateScreenState extends ConsumerState<PetitionCreateScreen> {
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  List<PetitionAttachment> _attachments = const [];

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  int get _remainingSlots => petitionMaxAttachments - _attachments.length;
  bool get _canAddMore => _remainingSlots > 0;

  Future<void> _pickPhotoFromGallery() async {
    final l10n = AppLocalizations.of(context);
    final picker = ref.read(petitionAttachmentPickerServiceProvider);
    final items = await picker.pickPhotosFromGallery(
      remainingSlots: _remainingSlots,
    );
    if (!mounted || items.isEmpty) {
      return;
    }

    _appendAttachments(items, l10n);
  }

  Future<void> _pickPhotoFromCamera() async {
    final l10n = AppLocalizations.of(context);
    if (!_canAddMore) {
      _showLimitReached(l10n);
      return;
    }

    final item =
        await ref.read(petitionAttachmentPickerServiceProvider).pickPhotoFromCamera();
    if (!mounted || item == null) {
      return;
    }

    _appendAttachments([item], l10n);
  }

  Future<void> _pickFile() async {
    final l10n = AppLocalizations.of(context);
    final items = await ref
        .read(petitionAttachmentPickerServiceProvider)
        .pickDocuments(remainingSlots: _remainingSlots);
    if (!mounted || items.isEmpty) {
      return;
    }

    _appendAttachments(items, l10n);
  }

  void _appendAttachments(List<PetitionAttachment> items, AppLocalizations l10n) {
    final accepted = <PetitionAttachment>[];
    for (final item in items) {
      if (_attachments.length + accepted.length >= petitionMaxAttachments) {
        break;
      }

      if (PetitionAttachment.validateKind(item.kind) != null) {
        _showTypeNotAllowed(l10n);
        continue;
      }

      accepted.add(item);
    }

    if (accepted.isEmpty) {
      return;
    }

    setState(() => _attachments = [..._attachments, ...accepted]);

    if (_attachments.length >= petitionMaxAttachments) {
      _showLimitReached(l10n);
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments = [
        for (var i = 0; i < _attachments.length; i++)
          if (i != index) _attachments[i],
      ];
    });
  }

  void _showLimitReached(AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.petitionAttachmentLimitReached)),
    );
  }

  void _showTypeNotAllowed(AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.petitionAttachmentTypeNotAllowed)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createPetition),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: l10n.petitionTitle,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _summaryController,
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: l10n.petitionSummary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPetitionAttachmentEditor(
            attachments: _attachments,
            canAddMore: _canAddMore,
            onPickPhotoCamera: _pickPhotoFromCamera,
            onPickPhotoGallery: _pickPhotoFromGallery,
            onPickFile: _pickFile,
            onRemove: _removeAttachment,
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: _submit,
            child: Text(l10n.createPetition),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final controller = ref.read(petitionsControllerProvider);
    await controller.createPetition(
      title: _titleController.text.trim(),
      summary: _summaryController.text.trim(),
      attachments: _attachments,
    );

    if (!mounted) {
      return;
    }

    context.pop();
  }
}
