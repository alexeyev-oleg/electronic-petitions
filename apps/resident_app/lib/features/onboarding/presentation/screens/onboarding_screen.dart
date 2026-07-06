import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../profile/application/preferences_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _pageIndex = 0;

  static const _pageCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(preferencesControllerProvider.notifier).completeOnboarding();
    if (!mounted) return;
    context.go('/auth');
  }

  void _next() {
    if (_pageIndex >= _pageCount - 1) {
      _finish();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preferences = ref.watch(preferencesControllerProvider);

    final slides = [
      _OnboardingSlideData(
        icon: Icons.account_balance_outlined,
        iconColor: AppColors.primary,
        title: l10n.onboardingSlideWelcomeTitle,
        body: l10n.onboardingSlideWelcomeBody,
        showLanguagePicker: true,
      ),
      _OnboardingSlideData(
        icon: Icons.how_to_vote_outlined,
        iconColor: AppColors.primary,
        title: l10n.onboardingSlidePetitionsTitle,
        body: l10n.onboardingSlidePetitionsBody,
      ),
      _OnboardingSlideData(
        icon: Icons.report_problem_outlined,
        iconColor: AppColors.secondary,
        title: l10n.onboardingSlideComplaintsTitle,
        body: l10n.onboardingSlideComplaintsBody,
      ),
      _OnboardingSlideData(
        icon: Icons.local_police_outlined,
        iconColor: AppColors.statusPending,
        title: l10n.onboardingSlideViolationsTitle,
        body: l10n.onboardingSlideViolationsBody,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() => _pageIndex = index);
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      children: [
                        Expanded(
                          child: AppSectionCard(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: slide.iconColor
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    slide.icon,
                                    size: 36,
                                    color: slide.iconColor,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Text(
                                  slide.title,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  slide.body,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                                if (slide.showLanguagePicker) ...[
                                  const SizedBox(height: AppSpacing.lg),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      l10n.onboardingLanguagePrompt,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  DropdownButtonFormField<String>(
                                    value: preferences.locale.languageCode,
                                    items: AppLocalizations.supportedLocales
                                        .map((locale) {
                                      return DropdownMenuItem<String>(
                                        value: locale.languageCode,
                                        child: Text(
                                          _labelForLocale(locale.languageCode),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value == null) return;
                                      ref
                                          .read(preferencesControllerProvider
                                              .notifier)
                                          .setLocale(Locale(value));
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(slides.length, (index) {
                      final active = index == _pageIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primary
                              : AppColors.outline,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: _next,
                    child: Text(
                      _pageIndex >= _pageCount - 1
                          ? l10n.onboardingGetStarted
                          : l10n.onboardingNext,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _labelForLocale(String languageCode) {
    switch (languageCode) {
      case 'he':
        return 'Hebrew';
      case 'ru':
        return 'Russian';
      case 'ar':
        return 'Arabic';
      default:
        return 'English';
    }
  }
}

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
    this.showLanguagePicker = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;
  final bool showLanguagePicker;
}
