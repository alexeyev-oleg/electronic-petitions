import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_item_card.dart';
import '../../../../core/widgets/app_list_state_view.dart';
import '../../application/enforcement_controller.dart';

class EnforcementReportsListScreen extends ConsumerWidget {
  const EnforcementReportsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(enforcementControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.enforcement),
        actions: [
          IconButton(
            onPressed: () => context.push('/enforcement/create'),
            icon: const Icon(Icons.add),
            tooltip: l10n.createEnforcementReport,
          ),
        ],
      ),
      body: AppListStateView(
        isLoading: controller.isLoading,
        hasLoadError: controller.hasLoadError,
        isEmpty: controller.reports.isEmpty,
        emptyMessage: l10n.emptyEnforcementReports,
        emptyActionLabel: l10n.createEnforcementReport,
        onEmptyAction: () => context.push('/enforcement/create'),
        onRetry: () => ref.read(enforcementControllerProvider).load(),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: controller.reports.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final report = controller.reports[index];
            return AppListItemCard(
              title: report.title,
              subtitle: report.locationLabel,
              status: report.status,
              onTap: () => context.push('/enforcement/${report.id}'),
            );
          },
        ),
      ),
    );
  }
}
