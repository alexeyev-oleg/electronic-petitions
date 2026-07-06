import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/mock/mock_local_store.dart';
import '../../../../core/mock/mock_snapshot_importer.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../triage/application/triage_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final user = auth.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.go('/login');
        }
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inspectorHomeTitle),
        actions: [
          TextButton(
            onPressed: auth.isLoading
                ? null
                : () async {
                    await ref.read(authControllerProvider.notifier).signOut();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
            child: Text(l10n.signOutAction),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            user?.fullName ?? l10n.appTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.inspectorHomeSubtitle),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: Text(l10n.badgeIdLabel),
              subtitle: Text(user?.badgeId ?? '-'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Card(
            child: ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: Text(l10n.inspectorRoleLabel),
              subtitle: Text(user?.role ?? '-'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: ListTile(
              leading: const Icon(Icons.inbox_outlined),
              title: Text(l10n.openTriageQueueAction),
              subtitle: Text(l10n.triageQueueTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/triage'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _PlaceholderTile(
            icon: Icons.directions_walk_outlined,
            label: l10n.dispatchQueuePlaceholder,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _MockSyncCard(),
        ],
      ),
    );
  }
}

class _PlaceholderTile extends StatelessWidget {
  const _PlaceholderTile({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.lock_clock_outlined),
      ),
    );
  }
}

class _MockSyncCard extends ConsumerStatefulWidget {
  const _MockSyncCard();

  @override
  ConsumerState<_MockSyncCard> createState() => _MockSyncCardState();
}

class _MockSyncCardState extends ConsumerState<_MockSyncCard> {
  String? _importMessage;
  bool _importSuccess = false;

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

    final importResult = await MockSnapshotImporter.importInspectorSnapshot(
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

    await ref.read(triageControllerProvider).load();
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.mockSyncTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.importMockSnapshotHelp,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: _onImportSnapshot,
              icon: const Icon(Icons.upload_file_outlined),
              label: Text(l10n.importMockSnapshot),
            ),
            if (_importMessage != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                _importMessage!,
                style: TextStyle(
                  color: _importSuccess
                      ? AppColors.statusSuccess
                      : AppColors.statusWarning,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
