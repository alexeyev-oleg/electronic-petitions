import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';

class AppListStateView extends StatelessWidget {
  const AppListStateView({
    super.key,
    required this.isLoading,
    required this.hasLoadError,
    required this.isEmpty,
    required this.emptyMessage,
    required this.onRetry,
    this.emptyActionLabel,
    this.onEmptyAction,
    required this.child,
  });

  final bool isLoading;
  final bool hasLoadError;
  final bool isEmpty;
  final String emptyMessage;
  final VoidCallback onRetry;
  final String? emptyActionLabel;
  final VoidCallback? onEmptyAction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasLoadError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.loadErrorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: onRetry,
                child: Text(l10n.retryAction),
              ),
            ],
          ),
        ),
      );
    }

    if (isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (emptyActionLabel != null && onEmptyAction != null) ...[
                const SizedBox(height: AppSpacing.md),
                FilledButton(
                  onPressed: onEmptyAction,
                  child: Text(emptyActionLabel!),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return child;
  }
}
