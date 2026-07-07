import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_links.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../../core/widgets/gesher_brand_mark.dart';
import '../../../profile/application/preferences_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _pageIndex = 0;

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
    if (_pageIndex >= _slides.length - 1) {
      _finish();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  Future<void> _openPublicWeb() async {
    final uri = Uri.parse(AppLinks.publicWebUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  List<_OnboardingSlideData> get _slides {
    final l10n = AppLocalizations.of(context);
    return [
      _OnboardingSlideData(
        useBrandMark: true,
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
      _OnboardingSlideData(
        icon: Icons.language_outlined,
        iconColor: AppColors.primary,
        title: l10n.onboardingSlideWebTitle,
        body: l10n.onboardingSlideWebBody,
        showPublicWebCta: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preferences = ref.watch(preferencesControllerProvider);
    final slides = _slides;

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
                                if (slide.useBrandMark)
                                  GesherBrandMark(
                                    size: 88,
                                    tagline: l10n.brandTagline,
                                  )
                                else
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
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
                                    alignment:
                                        AlignmentDirectional.centerStart,
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
                                if (slide.showPublicWebCta) ...[
                                  const SizedBox(height: AppSpacing.lg),
                                  OutlinedButton.icon(
                                    onPressed: _openPublicWeb,
                                    icon: const Icon(Icons.open_in_new),
                                    label: Text(l10n.onboardingOpenWebAction),
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
                  Semantics(
                    button: true,
                    label: _pageIndex >= slides.length - 1
                        ? l10n.onboardingGetStarted
                        : l10n.onboardingNext,
                    child: FilledButton(
                      onPressed: _next,
                      child: Text(
                        _pageIndex >= slides.length - 1
                            ? l10n.onboardingGetStarted
                            : l10n.onboardingNext,
                      ),
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
    required this.title,
    required this.body,
    this.icon = Icons.circle_outlined,
    this.iconColor = AppColors.primary,
    this.useBrandMark = false,
    this.showLanguagePicker = false,
    this.showPublicWebCta = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;
  final bool useBrandMark;
  final bool showLanguagePicker;
  final bool showPublicWebCta;
}
