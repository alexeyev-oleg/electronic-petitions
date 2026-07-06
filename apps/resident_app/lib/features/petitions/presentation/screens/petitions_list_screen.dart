import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_item_card.dart';
import '../../../../core/widgets/app_list_state_view.dart';
import '../../application/petitions_controller.dart';

class PetitionsListScreen extends ConsumerStatefulWidget {
  const PetitionsListScreen({super.key});

  @override
  ConsumerState<PetitionsListScreen> createState() =>
      _PetitionsListScreenState();
}

class _PetitionsListScreenState extends ConsumerState<PetitionsListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(petitionsControllerProvider);
    final petitions = controller.filteredPetitions;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.petitions),
        actions: [
          IconButton(
            onPressed: () => context.push('/petitions/create'),
            icon: const Icon(Icons.add),
            tooltip: l10n.createPetition,
          ),
          IconButton(
            onPressed: () => context.push('/petitions/mine'),
            icon: const Icon(Icons.folder_copy_outlined),
            tooltip: l10n.myPetitions,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: ref.read(petitionsControllerProvider).setSearchQuery,
              decoration: InputDecoration(
                labelText: l10n.searchPetitions,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                _FilterChip(
                  label: l10n.filterAll,
                  selected: controller.statusFilter == PetitionStatusFilter.all,
                  onSelected: () => ref
                      .read(petitionsControllerProvider)
                      .setStatusFilter(PetitionStatusFilter.all),
                ),
                _FilterChip(
                  label: l10n.filterPublished,
                  selected:
                      controller.statusFilter == PetitionStatusFilter.published,
                  onSelected: () => ref
                      .read(petitionsControllerProvider)
                      .setStatusFilter(PetitionStatusFilter.published),
                ),
                _FilterChip(
                  label: l10n.filterInReview,
                  selected:
                      controller.statusFilter == PetitionStatusFilter.inReview,
                  onSelected: () => ref
                      .read(petitionsControllerProvider)
                      .setStatusFilter(PetitionStatusFilter.inReview),
                ),
                _FilterChip(
                  label: l10n.filterDraft,
                  selected: controller.statusFilter == PetitionStatusFilter.draft,
                  onSelected: () => ref
                      .read(petitionsControllerProvider)
                      .setStatusFilter(PetitionStatusFilter.draft),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: AppListStateView(
              isLoading: controller.isLoading,
              hasLoadError: controller.hasLoadError,
              isEmpty: petitions.isEmpty,
              emptyMessage: l10n.noPetitionsMatch,
              emptyActionLabel: l10n.createPetition,
              onEmptyAction: () => context.push('/petitions/create'),
              onRetry: () => ref.read(petitionsControllerProvider).load(),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: petitions.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final petition = petitions[index];
                  return AppListItemCard(
                    title: petition.title,
                    subtitle:
                        '${l10n.signatureCountLabel}: ${petition.signatureCount}',
                    status: petition.status,
                    onTap: () => context.push('/petitions/${petition.id}'),
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
