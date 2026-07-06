import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_item_card.dart';
import '../../../../core/widgets/app_list_state_view.dart';
import '../../application/complaints_controller.dart';

class ComplaintsListScreen extends ConsumerWidget {
  const ComplaintsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(complaintsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.complaints),
        actions: [
          IconButton(
            onPressed: () => context.push('/complaints/create'),
            icon: const Icon(Icons.add),
            tooltip: l10n.createComplaint,
          ),
        ],
      ),
      body: AppListStateView(
        isLoading: controller.isLoading,
        hasLoadError: controller.hasLoadError,
        isEmpty: controller.complaints.isEmpty,
        emptyMessage: l10n.emptyComplaints,
        emptyActionLabel: l10n.createComplaint,
        onEmptyAction: () => context.push('/complaints/create'),
        onRetry: () => ref.read(complaintsControllerProvider).load(),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: controller.complaints.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final complaint = controller.complaints[index];
            return AppListItemCard(
              title: complaint.title,
              subtitle: complaint.locationLabel,
              status: complaint.status,
              onTap: () => context.push('/complaints/${complaint.id}'),
            );
          },
        ),
      ),
    );
  }
}
