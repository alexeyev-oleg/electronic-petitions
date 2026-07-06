import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_item_card.dart';
import '../../../../core/widgets/app_list_state_view.dart';
import '../../application/triage_controller.dart';

class TriageQueueScreen extends ConsumerWidget {
  const TriageQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(triageControllerProvider);
    final reports = controller.filteredReports;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.triageQueueTitle),
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
                      controller.statusFilter == TriageStatusFilter.all,
                  onSelected: (_) => ref
                      .read(triageControllerProvider)
                      .setStatusFilter(TriageStatusFilter.all),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterTriage),
                  selected:
                      controller.statusFilter == TriageStatusFilter.triage,
                  onSelected: (_) => ref
                      .read(triageControllerProvider)
                      .setStatusFilter(TriageStatusFilter.triage),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterReviewRequired),
                  selected: controller.statusFilter ==
                      TriageStatusFilter.reviewRequired,
                  onSelected: (_) => ref
                      .read(triageControllerProvider)
                      .setStatusFilter(TriageStatusFilter.reviewRequired),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterTrustAll),
                  selected: controller.trustFilter == TriageTrustFilter.all,
                  onSelected: (_) => ref
                      .read(triageControllerProvider)
                      .setTrustFilter(TriageTrustFilter.all),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterTrustStandard),
                  selected:
                      controller.trustFilter == TriageTrustFilter.standard,
                  onSelected: (_) => ref
                      .read(triageControllerProvider)
                      .setTrustFilter(TriageTrustFilter.standard),
                ),
                const SizedBox(width: AppSpacing.xs),
                FilterChip(
                  label: Text(l10n.filterTrustLowGeo),
                  selected: controller.trustFilter ==
                      TriageTrustFilter.lowGeoConfidence,
                  onSelected: (_) => ref
                      .read(triageControllerProvider)
                      .setTrustFilter(TriageTrustFilter.lowGeoConfidence),
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
              emptyMessage: l10n.emptyTriageQueue,
              onRetry: () => ref.read(triageControllerProvider).load(),
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
                    onTap: () => context.push('/triage/${report.id}'),
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
