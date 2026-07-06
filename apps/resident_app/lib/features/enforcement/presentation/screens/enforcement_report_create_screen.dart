import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/models/device_location.dart';
import '../../../../core/models/location_confirm_payload.dart';
import '../../../../core/models/media_attachment.dart';
import '../../../../core/services/location_capture_service.dart';
import '../../../../core/services/media_picker_service.dart';
import '../../../../core/widgets/app_media_attachment_editor.dart';
import '../../application/enforcement_report_draft.dart';

class EnforcementReportCreateScreen extends ConsumerStatefulWidget {
  const EnforcementReportCreateScreen({super.key});

  @override
  ConsumerState<EnforcementReportCreateScreen> createState() =>
      _EnforcementReportCreateScreenState();
}

class _EnforcementReportCreateScreenState
    extends ConsumerState<EnforcementReportCreateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  DeviceLocation? _deviceLocation;
  List<MediaAttachment> _mediaAttachments = const [];
  bool _geoMismatchOverride = false;
  bool _isCapturingLocation = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  bool get _geoMismatch =>
      _geoMismatchOverride || (_deviceLocation?.geoMismatch ?? false);

  Future<void> _captureLocation() async {
    setState(() => _isCapturingLocation = true);

    final location =
        await ref.read(locationCaptureServiceProvider).captureCurrentLocation();

    if (!mounted) return;

    setState(() {
      _deviceLocation = location;
      _isCapturingLocation = false;
    });

    if (location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).captureLocationFailed)),
      );
    }
  }

  Future<void> _pickPhotoFromGallery() async {
    final items =
        await ref.read(mediaPickerServiceProvider).pickPhotosFromGallery();
    if (!mounted || items.isEmpty) return;
    setState(() => _mediaAttachments = [..._mediaAttachments, ...items]);
  }

  Future<void> _pickPhotoFromCamera() async {
    final item = await ref
        .read(mediaPickerServiceProvider)
        .pickPhotoFromCamera(locationHint: _deviceLocation);
    if (!mounted || item == null) return;
    setState(() => _mediaAttachments = [..._mediaAttachments, item]);
  }

  Future<void> _pickVideoFromGallery() async {
    final item =
        await ref.read(mediaPickerServiceProvider).pickVideoFromGallery();
    if (!mounted || item == null) return;
    setState(() => _mediaAttachments = [..._mediaAttachments, item]);
  }

  Future<void> _pickVideoFromCamera() async {
    final item = await ref
        .read(mediaPickerServiceProvider)
        .pickVideoFromCamera(locationHint: _deviceLocation);
    if (!mounted || item == null) return;
    setState(() => _mediaAttachments = [..._mediaAttachments, item]);
  }

  void _removeAttachment(int index) {
    setState(() {
      _mediaAttachments = [
        for (var i = 0; i < _mediaAttachments.length; i++)
          if (i != index) _mediaAttachments[i],
      ];
    });
  }

  String? _resolveLocationLabel(AppLocalizations l10n) {
    final manualAddress = _locationController.text.trim();

    if (_geoMismatch && manualAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.manualAddressRequired)),
      );
      return null;
    }

    final locationLabel = manualAddress.isNotEmpty
        ? manualAddress
        : _deviceLocation?.coordinatesLabel ?? '';

    if (locationLabel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.captureLocationFailed)),
      );
      return null;
    }

    return locationLabel;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createEnforcementReport),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: l10n.enforcementTitle,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _descriptionController,
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: l10n.enforcementDescription,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.locationLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: _isCapturingLocation ? null : _captureLocation,
            icon: _isCapturingLocation
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            label: Text(l10n.useCurrentLocation),
          ),
          if (_deviceLocation != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('${l10n.deviceCoordinates}: ${_deviceLocation!.coordinatesLabel}'),
            if (_geoMismatch) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.geoMismatchDetected,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _geoMismatchOverride,
            title: Text(l10n.locationMismatchToggle),
            subtitle: Text(l10n.locationMismatchHelp),
            onChanged: (value) {
              setState(() => _geoMismatchOverride = value);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: l10n.manualAddress,
              helperText: _geoMismatch ? l10n.manualAddressRequiredNotice : null,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppMediaAttachmentEditor(
            attachments: _mediaAttachments,
            onPickPhotoCamera: _pickPhotoFromCamera,
            onPickPhotoGallery: _pickPhotoFromGallery,
            onPickVideoCamera: _pickVideoFromCamera,
            onPickVideoGallery: _pickVideoFromGallery,
            onRemove: _removeAttachment,
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton(
            onPressed: _review,
            child: Text(l10n.reviewEvidence),
          ),
        ],
      ),
    );
  }

  Future<void> _review() async {
    final l10n = AppLocalizations.of(context);
    final locationLabel = _resolveLocationLabel(l10n);
    if (locationLabel == null) return;

    final confirmed = await context.push<bool>(
      '/location/confirm',
      extra: LocationConfirmPayload(
        locationLabel: locationLabel,
        latitude: _deviceLocation?.latitude,
        longitude: _deviceLocation?.longitude,
        geoMismatch: _geoMismatch,
      ),
    );

    if (!mounted || confirmed != true) return;

    final draft = EnforcementReportDraft(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      locationLabel: locationLabel,
      geoMismatch: _geoMismatch,
      latitude: _deviceLocation?.latitude,
      longitude: _deviceLocation?.longitude,
      mediaAttachments: _mediaAttachments,
    );

    context.push('/enforcement/review', extra: draft);
  }
}
