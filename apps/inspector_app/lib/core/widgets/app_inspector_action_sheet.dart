import 'package:flutter/material.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';
import '../../features/triage/application/inspector_triage_action.dart';

class AppInspectorActionSheet {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final l10n = AppLocalizations.of(context);
    final otpController = TextEditingController();
    var isSubmitting = false;

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.md,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + AppSpacing.md,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Text(message),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.mockOtpHint(InspectorMockSecurity.mockOtpCode),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: l10n.otpCodeLabel,
                      prefixIcon: const Icon(Icons.pin_outlined),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            setState(() => isSubmitting = true);
                            final code = otpController.text.trim();
                            if (code != InspectorMockSecurity.mockOtpCode) {
                              setState(() => isSubmitting = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.otpInvalid)),
                              );
                              return;
                            }
                            Navigator.of(sheetContext).pop(true);
                          },
                    child: isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.confirmSensitiveAction),
                  ),
                  TextButton(
                    onPressed: isSubmitting
                        ? null
                        : () => Navigator.of(sheetContext).pop(false),
                    child: Text(l10n.cancelAction),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    otpController.dispose();
    return confirmed ?? false;
  }
}
