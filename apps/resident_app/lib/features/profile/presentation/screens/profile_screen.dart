import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/environment/app_environment.dart';
import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/mock/mock_local_store.dart';
import '../../../../core/mock/mock_snapshot_exporter.dart';
import '../../../../core/mock/mock_snapshot_importer.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../core/widgets/app_feature_tile.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../../shared/models/kyc_status.dart';
import '../../../../shared/models/notification_preferences.dart';
import '../../../../shared/models/session_tier.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../complaints/application/complaints_controller.dart';
import '../../../enforcement/application/enforcement_controller.dart';
import '../../../notifications/application/app_notification.dart';
import '../../../notifications/application/notifications_controller.dart';
import '../../../notifications/presentation/notification_navigation.dart';
import '../../../petitions/application/petitions_controller.dart';
import '../../application/preferences_controller.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final preferences = ref.watch(preferencesControllerProvider);
    final environment = ref.watch(appEnvironmentProvider);
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppSectionCard(
            title: l10n.accountInformation,
            child: Text(
              user?.email ?? '-',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppSectionCard(
            title: l10n.language,
            child: DropdownButtonFormField<String>(
              value: preferences.locale.languageCode,
              items: AppLocalizations.supportedLocales.map((locale) {
                return DropdownMenuItem<String>(
                  value: locale.languageCode,
                  child: Text(_labelForLocale(locale.languageCode)),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                ref
                    .read(preferencesControllerProvider)
                    .setLocale(Locale(value));
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppSectionCard(
            title: l10n.notificationPreferences,
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.emailNotifications),
                  value: preferences.notificationPreferences.emailEnabled,
                  onChanged: (value) {
                    _updatePreferences(
                      ref,
                      preferences.notificationPreferences.copyWith(
                        emailEnabled: value,
                      ),
                    );
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.pushNotifications),
                  value: preferences.notificationPreferences.pushEnabled,
                  onChanged: (value) async {
                    await _updatePreferences(
                      ref,
                      preferences.notificationPreferences.copyWith(
                        pushEnabled: value,
                      ),
                    );
                    if (environment.enablePushScaffold) {
                      await ref
                          .read(pushNotificationServiceProvider)
                          .setEnabled(value);
                    }
                  },
                ),
              ],
            ),
          ),
          if (environment.enablePushScaffold) ...[
            const SizedBox(height: AppSpacing.sm),
            const _PushScaffoldSection(),
          ],
          if (user != null) ...[
            const SizedBox(height: AppSpacing.sm),
            AppSectionCard(
              title: l10n.secureVerificationTitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${l10n.sessionTierLabel}: ${user.sessionTier == SessionTier.secure ? l10n.sessionTierSecure : l10n.sessionTierBeta}',
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    user.phoneVerified
                        ? '${l10n.phoneVerifiedLabel}: ${user.phoneNumber ?? '-'}'
                        : l10n.phoneVerificationBanner,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('${l10n.kycStatusLabel}: ${_kycLabel(user.kycStatus, l10n)}'),
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton(
                    onPressed: () => context.push('/auth/verify-phone'),
                    child: Text(l10n.verifyPhoneCta),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  FilledButton(
                    onPressed: () => context.push('/auth/kyc'),
                    child: Text(l10n.startKycAction),
                  ),
                ],
              ),
            ),
          ],
          if (environment.usesMockApi) ...[
            const SizedBox(height: AppSpacing.sm),
            AppInfoBanner(message: l10n.mockDataPersistNotice),
            const SizedBox(height: AppSpacing.sm),
            const _MockBetaSettingsCard(),
          ],
          const SizedBox(height: AppSpacing.sm),
          AppFeatureTile(
            title: l10n.helpAndSupport,
            icon: Icons.help_outline,
            iconColor: AppColors.primary,
            onTap: () => context.push('/help'),
          ),
        ],
      ),
    );
  }

  Future<void> _updatePreferences(
    WidgetRef ref,
    NotificationPreferences preferences,
  ) async {
    await ref
        .read(preferencesControllerProvider)
        .updateNotificationPreferences(preferences);
  }

  String _labelForLocale(String languageCode) {
    switch (languageCode) {
      case 'he':
        return 'Hebrew';
      case 'ru':
        return 'Russian';
      case 'ar':
        return 'Arabic';
      default:
        return 'English';
    }
  }

  String _kycLabel(KycStatus status, AppLocalizations l10n) {
    switch (status) {
      case KycStatus.approved:
        return l10n.kycStatusApproved;
      case KycStatus.pending:
        return l10n.kycStatusPending;
      case KycStatus.manualReview:
        return l10n.kycStatusManualReview;
      case KycStatus.rejected:
        return l10n.kycStatusRejected;
      case KycStatus.notStarted:
        return l10n.kycStatusNotStarted;
    }
  }
}

class _PushScaffoldSection extends ConsumerWidget {
  const _PushScaffoldSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final push = ref.watch(pushNotificationServiceProvider);
    final preferences = ref.watch(preferencesControllerProvider);
    final enabled = preferences.notificationPreferences.pushEnabled;

    final statusText = !enabled
        ? l10n.pushStatusDisabled
        : push.deviceToken == null
            ? l10n.pushStatusPending
            : l10n.pushStatusRegistered;

    return AppSectionCard(
      title: l10n.pushScaffoldTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.pushScaffoldNotice),
          const SizedBox(height: AppSpacing.sm),
          Text(statusText),
          if (push.deviceToken != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text('${l10n.pushDeviceTokenLabel}: ${push.deviceToken}'),
          ],
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: enabled
                ? () => _simulatePush(context, ref, l10n)
                : null,
            child: Text(l10n.simulatePushAction),
          ),
        ],
      ),
    );
  }

  void _simulatePush(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final items = ref.read(notificationsControllerProvider).items;
    AppNotification? target;
    for (final item in items) {
      if (item.deepLink != null && item.deepLink!.isNotEmpty && !item.isRead) {
        target = item;
        break;
      }
    }
    target ??= () {
      for (final item in items) {
        if (item.deepLink != null && item.deepLink!.isNotEmpty) {
          return item;
        }
      }
      return null;
    }();

    if (target == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${target.title}: ${target.body}'),
        action: SnackBarAction(
          label: l10n.openNotificationAction,
          onPressed: () => openNotificationDeepLink(context, target!),
        ),
      ),
    );
  }
}

class _MockBetaSettingsCard extends ConsumerStatefulWidget {
  const _MockBetaSettingsCard();

  @override
  ConsumerState<_MockBetaSettingsCard> createState() =>
      _MockBetaSettingsCardState();
}

class _MockBetaSettingsCardState extends ConsumerState<_MockBetaSettingsCard> {
  bool _simulateLoadError = false;
  String? _importMessage;
  bool _importSuccess = false;

  @override
  void initState() {
    super.initState();
    _simulateLoadError = ref.read(mockLocalStoreProvider).simulateLoadError;
  }

  Future<void> _reloadFeatureLists() async {
    await Future.wait([
      ref.read(complaintsControllerProvider).load(),
      ref.read(enforcementControllerProvider).load(),
      ref.read(petitionsControllerProvider).load(),
      ref.read(notificationsControllerProvider).load(),
    ]);
  }

  Future<void> _onSimulateLoadErrorChanged(bool value) async {
    await ref.read(mockLocalStoreProvider).setSimulateLoadError(value);
    setState(() => _simulateLoadError = value);
    await _reloadFeatureLists();
  }

  Future<void> _onExportSnapshot() async {
    final l10n = AppLocalizations.of(context);
    try {
      final jsonText = await MockSnapshotExporter.exportResidentSnapshot(
        store: ref.read(mockLocalStoreProvider),
      );
      final saved = await FilePicker.platform.saveFile(
        fileName:
            'gesher-mock-${DateTime.now().toUtc().toIso8601String().replaceAll(':', '-')}.json',
        bytes: utf8.encode(jsonText),
        type: FileType.custom,
        allowedExtensions: const ['json'],
      );

      if (!mounted) {
        return;
      }

      if (saved == null) {
        return;
      }

      setState(() {
        _importSuccess = true;
        _importMessage = l10n.exportMockSnapshotSuccess;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _importSuccess = false;
        _importMessage = l10n.exportMockSnapshotFailed;
      });
    }
  }

  Future<void> _onImportSnapshot() async {
    final l10n = AppLocalizations.of(context);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final bytes = result.files.single.bytes;
    if (bytes == null) {
      setState(() {
        _importSuccess = false;
        _importMessage = l10n.importMockSnapshotFailed;
      });
      return;
    }

    final importResult = await MockSnapshotImporter.importResidentSnapshot(
      store: ref.read(mockLocalStoreProvider),
      jsonText: String.fromCharCodes(bytes),
    );

    if (!importResult.ok) {
      setState(() {
        _importSuccess = false;
        _importMessage = l10n.importMockSnapshotFailed;
      });
      return;
    }

    await _reloadFeatureLists();
    if (!mounted) {
      return;
    }
    setState(() {
      _importSuccess = true;
      _importMessage = l10n.importMockSnapshotSuccess;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AppSectionCard(
      title: l10n.mockBetaSettings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.simulateLoadError),
            subtitle: Text(l10n.simulateLoadErrorHelp),
            value: _simulateLoadError,
            onChanged: _onSimulateLoadErrorChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.importMockSnapshotHelp),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: _onImportSnapshot,
            icon: const Icon(Icons.upload_file_outlined),
            label: Text(l10n.importMockSnapshot),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.exportMockSnapshotHelp),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: _onExportSnapshot,
            icon: const Icon(Icons.download_outlined),
            label: Text(l10n.exportMockSnapshot),
          ),
          if (_importMessage != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _importMessage!,
              style: TextStyle(
                color: _importSuccess ? AppColors.statusSuccess : AppColors.statusWarning,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
