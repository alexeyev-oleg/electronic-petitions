import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/petition_attachment.dart';
import 'media_picker_service.dart';

final petitionAttachmentPickerServiceProvider =
    Provider<PetitionAttachmentPickerService>(
  (ref) => PetitionAttachmentPickerService(
    mediaPicker: ref.watch(mediaPickerServiceProvider),
  ),
);

class PetitionAttachmentPickerService {
  PetitionAttachmentPickerService({
    required MediaPickerService mediaPicker,
  }) : _mediaPicker = mediaPicker;

  final MediaPickerService _mediaPicker;

  static const allowedDocumentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
  ];

  Future<PetitionAttachment?> pickPhotoFromCamera() async {
    final media = await _mediaPicker.pickPhotoFromCamera();
    if (media == null) {
      return null;
    }

    return PetitionAttachment(
      path: media.path,
      kind: PetitionAttachmentKind.photo,
      displayName: _basename(media.path),
    );
  }

  Future<List<PetitionAttachment>> pickPhotosFromGallery({
    required int remainingSlots,
  }) async {
    if (remainingSlots <= 0) {
      return const [];
    }

    final mediaItems = await _mediaPicker.pickPhotosFromGallery();
    return mediaItems
        .take(remainingSlots)
        .map(
          (media) => PetitionAttachment(
            path: media.path,
            kind: PetitionAttachmentKind.photo,
            displayName: _basename(media.path),
          ),
        )
        .toList();
  }

  Future<List<PetitionAttachment>> pickDocuments({
    required int remainingSlots,
  }) async {
    if (remainingSlots <= 0) {
      return const [];
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedDocumentExtensions,
      allowMultiple: remainingSlots > 1,
    );
    if (result == null || result.files.isEmpty) {
      return const [];
    }

    final attachments = <PetitionAttachment>[];
    for (final file in result.files.take(remainingSlots)) {
      final path = file.path;
      if (path == null || path.isEmpty) {
        continue;
      }

      final kind = PetitionAttachment.kindForPath(path);
      if (kind == null || kind == PetitionAttachmentKind.photo) {
        continue;
      }

      attachments.add(
        PetitionAttachment(
          path: path,
          kind: kind,
          displayName: file.name.isNotEmpty ? file.name : _basename(path),
        ),
      );
    }

    return attachments;
  }

  String _basename(String path) {
    final segments = File(path).uri.pathSegments;
    if (segments.isEmpty) {
      return path;
    }
    return segments.last;
  }
}
