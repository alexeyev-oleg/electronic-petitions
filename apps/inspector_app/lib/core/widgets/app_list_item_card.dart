import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';
import 'app_status_chip.dart';

class AppListItemCard extends StatelessWidget {
  const AppListItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.onTap,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final String status;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppStatusChip(status: status),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
