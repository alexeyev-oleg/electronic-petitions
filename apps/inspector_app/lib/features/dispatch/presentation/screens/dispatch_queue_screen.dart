import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_list_item_card.dart';
import '../../../core/widgets/app_list_state_view.dart';
import '../application/dispatch_controller.dart';

class DispatchQueueScreen extends ConsumerWidget {
  const DispatchQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(dispatchControllerProvider);
    final reports = controller.filteredReports;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dispatchQueueTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.xs,
            ),
            child: Text(
              l10n.queueCountLabel(reports.length),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected:
                      controller.statusFilter == DispatchStatusFilter.all,
                  onSelected: (_) => ref
                      .read(dispatchControllerProvider)
                      .setStatusFilter(DispatchStatusFilter.all),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterDispatchAssigned),
                  selected: controller.statusFilter ==
                      DispatchStatusFilter.assigned,
                  onSelected: (_) => ref
                      .read(dispatchControllerProvider)
                      .setStatusFilter(DispatchStatusFilter.assigned),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterDispatchInField),
                  selected:
                      controller.statusFilter == DispatchStatusFilter.inField,
                  onSelected: (_) => ref
                      .read(dispatchControllerProvider)
                      .setStatusFilter(DispatchStatusFilter.inField),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterDispatchCompleted),
                  selected: controller.statusFilter ==
                      DispatchStatusFilter.completed,
                  onSelected: (_) => ref
                      .read(dispatchControllerProvider)
                      .setStatusFilter(DispatchStatusFilter.completed),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: AppListStateView(
              isLoading: controller.isLoading,
              hasLoadError: controller.hasLoadError,
              isEmpty: reports.isEmpty,
              emptyMessage: l10n.emptyDispatchQueue,
              onRetry: () => ref.read(dispatchControllerProvider).load(),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: reports.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return AppListItemCard(
                    title: report.title,
                    subtitle:
                        '${report.locationLabel} · ${report.trustLabel.replaceAll('_', ' ')}',
                    status: report.status,
                    trailing: report.hasMedia
                        ? const Icon(Icons.perm_media_outlined)
                        : null,
                    onTap: () => context.push('/dispatch/${report.id}'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
