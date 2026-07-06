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
    required this.child,
  });

  final bool isLoading;
  final bool hasLoadError;
  final bool isEmpty;
  final String emptyMessage;
  final VoidCallback onRetry;
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
              Text(l10n.loadErrorMessage, textAlign: TextAlign.center),
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
          child: Text(emptyMessage, textAlign: TextAlign.center),
        ),
      );
    }

    return child;
  }
}
