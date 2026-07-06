import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/device_location.dart';
import '../models/media_attachment.dart';

final mediaPickerServiceProvider = Provider<MediaPickerService>(
  (_) => MediaPickerService(),
);

class MediaPickerService {
  MediaPickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<List<MediaAttachment>> pickPhotosFromGallery() async {
    final files = await _picker.pickMultiImage(imageQuality: 85);
    return files
        .map(
          (file) => MediaAttachment(
            path: file.path,
            kind: MediaKind.photo,
          ),
        )
        .where((item) => item.path.isNotEmpty)
        .toList();
  }

  Future<MediaAttachment?> pickPhotoFromCamera({
    DeviceLocation? locationHint,
  }) async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (file == null || file.path.isEmpty) {
      return null;
    }

    return MediaAttachment(
      path: file.path,
      kind: MediaKind.photo,
      exifLatitude: locationHint?.latitude,
      exifLongitude: locationHint?.longitude,
    );
  }

  Future<MediaAttachment?> pickVideoFromCamera({
    DeviceLocation? locationHint,
  }) async {
    final file = await _picker.pickVideo(source: ImageSource.camera);
    if (file == null || file.path.isEmpty) {
      return null;
    }

    return MediaAttachment(
      path: file.path,
      kind: MediaKind.video,
      exifLatitude: locationHint?.latitude,
      exifLongitude: locationHint?.longitude,
    );
  }

  Future<MediaAttachment?> pickVideoFromGallery() async {
    final file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file == null || file.path.isEmpty) {
      return null;
    }

    return MediaAttachment(
      path: file.path,
      kind: MediaKind.video,
    );
  }
}
