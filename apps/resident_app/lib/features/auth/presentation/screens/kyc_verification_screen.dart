import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../../../shared/models/kyc_status.dart';
import '../../application/auth_controller.dart';
import '../../application/auth_validators.dart';

class KycVerificationScreen extends ConsumerStatefulWidget {
  const KycVerificationScreen({super.key});

  @override
  ConsumerState<KycVerificationScreen> createState() =>
      _KycVerificationScreenState();
}

class _KycVerificationScreenState extends ConsumerState<KycVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _documentController = TextEditingController();
  var _documentCaptured = false;
  var _selfieCaptured = false;

  @override
  void dispose() {
    _documentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final user = auth.currentUser;
    final kycStatus = user?.kycStatus ?? KycStatus.notStarted;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.kycVerificationTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppInfoBanner(message: l10n.kycVerificationHelp),
          const SizedBox(height: AppSpacing.md),
          AppSectionCard(
            title: l10n.kycStatusLabel,
            child: Row(
              children: [
                AppStatusChip(status: _statusChipValue(kycStatus)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(_statusLabel(kycStatus, l10n))),
              ],
            ),
          ),
          if (user?.phoneVerified != true) ...[
            const SizedBox(height: AppSpacing.md),
            AppInfoBanner(
              message: l10n.phoneRequiredBeforeKyc,
              icon: Icons.phone_android_outlined,
            ),
            const SizedBox(height: AppSpacing.sm),
            FilledButton(
              onPressed: () => context.push('/auth/verify-phone'),
              child: Text(l10n.verifyPhoneAction),
            ),
          ] else if (kycStatus == KycStatus.approved) ...[
            const SizedBox(height: AppSpacing.md),
            AppInfoBanner(
              message: l10n.kycApprovedNotice,
              icon: Icons.verified_outlined,
            ),
          ] else ...[
            const SizedBox(height: AppSpacing.md),
            AppSectionCard(
              title: l10n.kycDocumentStepTitle,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _documentController,
                      enabled: !auth.isLoading,
                      validator: (value) =>
                          AuthValidators.documentNumber(value, l10n),
                      decoration: InputDecoration(
                        labelText: l10n.documentNumberLabel,
                        prefixIcon: const Icon(Icons.badge_outlined),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    OutlinedButton.icon(
                      onPressed: auth.isLoading
                          ? null
                          : () => setState(() => _documentCaptured = true),
                      icon: Icon(
                        _documentCaptured
                            ? Icons.check_circle_outline
                            : Icons.document_scanner_outlined,
                      ),
                      label: Text(l10n.simulateDocumentCapture),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: auth.isLoading
                          ? null
                          : () => setState(() => _selfieCaptured = true),
                      icon: Icon(
                        _selfieCaptured
                            ? Icons.check_circle_outline
                            : Icons.face_retouching_natural_outlined,
                      ),
                      label: Text(l10n.simulateSelfieCapture),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: auth.isLoading ||
                              !_documentCaptured ||
                              !_selfieCaptured
                          ? null
                          : _submitKyc,
                      child: auth.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.submitKycAction),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _submitKyc() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authControllerProvider);
    await auth.startKycSession();
    if (!mounted) return;

    final success = await auth.submitMockKyc(
      documentNumber: _documentController.text.trim(),
    );
    if (!mounted) return;

    if (!success) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.errorMessage == 'document_invalid'
                ? l10n.documentNumberInvalid
                : l10n.loadErrorMessage,
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).kycApprovedNotice)),
    );
    context.pop();
  }

  String _statusChipValue(KycStatus status) {
    switch (status) {
      case KycStatus.approved:
        return 'approved';
      case KycStatus.pending:
        return 'pending';
      case KycStatus.manualReview:
        return 'manual_review';
      case KycStatus.rejected:
        return 'rejected';
      case KycStatus.notStarted:
        return 'not_started';
    }
  }

  String _statusLabel(KycStatus status, AppLocalizations l10n) {
    switch (status) {
      case KycStatus.approved:
        return l10n.kycStatusApproved;
      case KycStatus.pending:
        return l10n.kycStatusPending;
      case KycStatus.manualReview:
        return l10n.kycStatusManualReview;
      case KycStatus.rejected:
        return l10n.kycStatusRejected;
      case KycStatus.notStarted:
        return l10n.kycStatusNotStarted;
    }
  }
}
