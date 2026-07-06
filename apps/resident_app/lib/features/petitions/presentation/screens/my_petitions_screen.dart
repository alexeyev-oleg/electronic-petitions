import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_item_card.dart';
import '../../../../core/widgets/app_list_state_view.dart';
import '../../application/petitions_controller.dart';

class MyPetitionsScreen extends ConsumerWidget {
  const MyPetitionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(petitionsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myPetitions),
      ),
      body: AppListStateView(
        isLoading: controller.isLoading,
        hasLoadError: controller.hasLoadError,
        isEmpty: controller.myPetitions.isEmpty,
        emptyMessage: l10n.noPetitionsYet,
        emptyActionLabel: l10n.createPetition,
        onEmptyAction: () => context.push('/petitions/create'),
        onRetry: () => ref.read(petitionsControllerProvider).load(),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: controller.myPetitions.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final petition = controller.myPetitions[index];
            return AppListItemCard(
              title: petition.title,
              subtitle: petition.summary,
              status: petition.status,
              onTap: () => context.push('/petitions/${petition.id}'),
            );
          },
        ),
      ),
    );
  }
}
