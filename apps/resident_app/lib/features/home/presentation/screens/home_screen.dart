import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_feature_tile.dart';
import '../../../../core/widgets/app_info_banner.dart';
import '../../../../shared/models/session_tier.dart';
import '../../../auth/application/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.watch(authControllerProvider);
    final user = controller.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          TextButton(
            onPressed: controller.isLoading
                ? null
                : () => ref.read(authControllerProvider).signOut(),
            child: Text(l10n.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          if (user != null) ...[
            Text(
              user.email,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${l10n.sessionTierLabel}: ${user.sessionTier == SessionTier.secure ? l10n.sessionTierSecure : l10n.sessionTierBeta}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          AppInfoBanner(message: l10n.mockModeNotice),
          if (user != null && !user.emailVerified) ...[
            const SizedBox(height: AppSpacing.sm),
            AppInfoBanner(
              message: l10n.emailVerificationPending,
              icon: Icons.mark_email_unread_outlined,
            ),
          ],
          if (user != null && user.needsPhoneVerification) ...[
            const SizedBox(height: AppSpacing.sm),
            AppInfoBanner(
              message: l10n.phoneVerificationBanner,
              icon: Icons.phone_android_outlined,
            ),
          ],
          if (user != null && user.needsKycVerification) ...[
            const SizedBox(height: AppSpacing.sm),
            AppInfoBanner(
              message: l10n.kycRequiredBanner,
              icon: Icons.verified_user_outlined,
            ),
          ],
          if (user != null &&
              (user.needsPhoneVerification || user.needsKycVerification)) ...[
            const SizedBox(height: AppSpacing.sm),
            AppInfoBanner(message: l10n.secureUpgradeNotice),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppFeatureTile(
            title: l10n.petitions,
            icon: Icons.how_to_vote_outlined,
            iconColor: AppColors.primary,
            onTap: () => context.push('/petitions'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppFeatureTile(
            title: l10n.complaints,
            icon: Icons.report_problem_outlined,
            iconColor: AppColors.secondary,
            onTap: () => context.push('/complaints'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppFeatureTile(
            title: l10n.enforcement,
            icon: Icons.local_police_outlined,
            iconColor: AppColors.statusPending,
            onTap: () => context.push('/enforcement'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppFeatureTile(
            title: l10n.inbox,
            icon: Icons.notifications_outlined,
            iconColor: AppColors.statusActive,
            onTap: () => context.push('/inbox'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppFeatureTile(
            title: l10n.profile,
            icon: Icons.person_outline,
            iconColor: AppColors.statusNeutral,
            onTap: () => context.push('/profile'),
          ),
        ],
      ),
    );
  }
}
