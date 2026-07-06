import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.statusColor(status);

    return Chip(
      label: Text(status.replaceAll('_', ' ')),
      labelStyle: TextStyle(color: color),
      backgroundColor: AppColors.statusBackground(status),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}
