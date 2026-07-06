import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../../shared/repositories/secure_storage_auth_repository.dart';
import '../../application/auth_controller.dart';
import '../../application/auth_validators.dart';

class PhoneVerificationScreen extends ConsumerStatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  ConsumerState<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState
    extends ConsumerState<PhoneVerificationScreen> {
  final _phoneFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.phoneVerificationTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppInfoBanner(message: l10n.phoneVerificationHelp),
          const SizedBox(height: AppSpacing.sm),
          AppInfoBanner(
            message: l10n.mockOtpHint(SecureStorageAuthRepository.mockOtpCode),
            icon: Icons.sms_outlined,
          ),
          if (user?.phoneVerified == true) ...[
            const SizedBox(height: AppSpacing.sm),
            AppSectionCard(
              title: l10n.phoneVerificationTitle,
              child: Text(
                '${l10n.phoneVerifiedLabel}: ${user!.phoneNumber ?? '-'}',
              ),
            ),
          ] else ...[
            const SizedBox(height: AppSpacing.md),
            AppSectionCard(
              title: l10n.phoneNumberLabel,
              child: Form(
                key: _phoneFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      enabled: !_otpSent && !auth.isLoading,
                      validator: (value) =>
                          AuthValidators.phoneNumber(value, l10n),
                      decoration: InputDecoration(
                        labelText: l10n.phoneNumberLabel,
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton(
                      onPressed: auth.isLoading || _otpSent ? null : _sendOtp,
                      child: Text(l10n.sendOtpAction),
                    ),
                  ],
                ),
              ),
            ),
            if (_otpSent) ...[
              const SizedBox(height: AppSpacing.md),
              AppSectionCard(
                title: l10n.otpCodeLabel,
                child: Form(
                  key: _otpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(l10n.otpSentNotice),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) =>
                            AuthValidators.otpCode(value, l10n),
                        decoration: InputDecoration(
                          labelText: l10n.otpCodeLabel,
                          prefixIcon: const Icon(Icons.pin_outlined),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        onPressed: auth.isLoading ? null : _verifyOtp,
                        child: auth.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(l10n.verifyPhoneAction),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Future<void> _sendOtp() async {
    if (!_phoneFormKey.currentState!.validate()) return;

    final success = await ref.read(authControllerProvider).sendPhoneOtp(
          phoneNumber: _phoneController.text.trim(),
        );
    if (!mounted || !success) {
      _showError();
      return;
    }

    setState(() => _otpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).otpSentNotice)),
    );
  }

  Future<void> _verifyOtp() async {
    if (!_otpFormKey.currentState!.validate()) return;

    final success = await ref.read(authControllerProvider).verifyPhoneOtp(
          phoneNumber: _phoneController.text.trim(),
          otpCode: _otpController.text.trim(),
        );
    if (!mounted) return;

    if (!success) {
      _showError();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).phoneVerifiedNotice)),
    );
    context.pop();
  }

  void _showError() {
    final code = ref.read(authControllerProvider).errorMessage;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_messageForCode(code, l10n))),
    );
  }

  String _messageForCode(String? code, AppLocalizations l10n) {
    switch (code) {
      case 'otp_invalid':
        return l10n.otpInvalid;
      case 'phone_mismatch':
        return l10n.phoneMismatchError;
      default:
        return l10n.loadErrorMessage;
    }
  }
}
