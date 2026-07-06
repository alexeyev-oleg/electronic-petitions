import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/localization/app_localizations.dart';
import '../../app/theme/app_spacing.dart';
import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/application/auth_validators.dart';
import '../../shared/repositories/secure_storage_auth_repository.dart';

class AppSensitiveActionSheet {
  static Future<bool> show(
    BuildContext context, {
    required WidgetRef ref,
    required String title,
    required String message,
  }) async {
    final l10n = AppLocalizations.of(context);
    final otpController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(message),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.mockOtpHint(
                        SecureStorageAuthRepository.mockOtpCode,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validator: (value) => AuthValidators.otpCode(value, l10n),
                      decoration: InputDecoration(
                        labelText: l10n.otpCodeLabel,
                        prefixIcon: const Icon(Icons.pin_outlined),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              setState(() => isSubmitting = true);
                              final success = await ref
                                  .read(authControllerProvider)
                                  .confirmSensitiveAction(
                                    otpCode: otpController.text.trim(),
                                  );
                              if (!context.mounted) return;
                              if (success) {
                                Navigator.of(sheetContext).pop(true);
                                return;
                              }
                              setState(() => isSubmitting = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _errorMessageForCode(
                                      ref.read(authControllerProvider).errorMessage,
                                      l10n,
                                    ),
                                  ),
                                ),
                              );
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
                ),
              );
            },
          ),
        );
      },
    );

    otpController.dispose();
    ref.read(authControllerProvider).clearFlowState();
    return confirmed ?? false;
  }

  static String _errorMessageForCode(String? code, AppLocalizations l10n) {
    switch (code) {
      case 'otp_invalid':
        return l10n.otpInvalid;
      case 'kyc_required':
        return l10n.kycRequiredForAction;
      case 'secure_session_required':
        return l10n.secureSessionRequired;
      default:
        return l10n.loadErrorMessage;
    }
  }
}
