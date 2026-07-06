import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_brand_header.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../application/auth_controller.dart';
import '../../application/auth_validators.dart';

class AuthGateScreen extends ConsumerStatefulWidget {
  const AuthGateScreen({super.key});

  @override
  ConsumerState<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends ConsumerState<AuthGateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;

  @override
  void initState() {
    super.initState();
    ref.read(authControllerProvider.notifier).ensureInitialized();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);

    if (auth.isLoading && !auth.isAuthenticated) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (auth.isAuthenticated) {
      return const HomeScreen();
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.formMaxWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBrandHeader(
                    title: l10n.appTitle,
                    subtitle: l10n.homeTitle,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppInfoBanner(message: l10n.secureUpgradeNotice),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Chip(
                              label: Text(l10n.betaBanner),
                              backgroundColor: AppColors.statusPending
                                  .withValues(alpha: 0.14),
                              labelStyle: const TextStyle(
                                color: AppColors.statusPending,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                AuthValidators.email(value, l10n),
                            decoration: InputDecoration(
                              labelText: l10n.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => AuthValidators.password(
                              value,
                              l10n,
                              isSignUp: _isSignUp,
                            ),
                            decoration: InputDecoration(
                              labelText: l10n.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                          ),
                          if (auth.errorMessage != null) ...[
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              auth.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          FilledButton(
                            onPressed: auth.isLoading ? null : _submit,
                            child: auth.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(_isSignUp ? l10n.signUp : l10n.signIn),
                          ),
                          TextButton(
                            onPressed: auth.isLoading
                                ? null
                                : () => context.push('/forgot-password'),
                            child: Text(l10n.forgotPassword),
                          ),
                          TextButton(
                            onPressed: auth.isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isSignUp = !_isSignUp;
                                    });
                                  },
                            child: Text(_isSignUp ? l10n.signIn : l10n.signUp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final controller = ref.read(authControllerProvider.notifier);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (_isSignUp) {
      await controller.signUp(email: email, password: password);
      return;
    }

    await controller.signIn(email: email, password: password);
  }
}
