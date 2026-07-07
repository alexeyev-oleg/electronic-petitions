import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class GesherBrandMark extends StatelessWidget {
  const GesherBrandMark({
    super.key,
    this.size = 88,
    this.inverted = false,
    this.showWordmark = true,
    this.tagline,
    this.badge,
  });

  final double size;
  final bool inverted;
  final bool showWordmark;
  final String? tagline;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final fg = inverted ? Colors.white : AppColors.graphite;
    final accent = inverted ? Colors.white : AppColors.terracotta;
    final subtitleColor =
        inverted ? Colors.white.withValues(alpha: 0.86) : AppColors.textMuted;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: inverted
                ? Colors.white.withValues(alpha: 0.14)
                : AppColors.terracotta.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(size * 0.22),
          ),
          alignment: Alignment.center,
          child: _LogoGlyph(
            size: size * 0.52,
            foreground: fg,
            accent: accent,
          ),
        ),
        if (showWordmark) ...[
          SizedBox(height: size * 0.2),
          Text(
            'G.E.S.H.E.R.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: fg,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
        if (badge != null && badge!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            badge!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: accent,
                  letterSpacing: 0.6,
                ),
          ),
        ],
        if (tagline != null && tagline!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            tagline!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                ),
          ),
        ],
      ],
    );
  }
}

class _LogoGlyph extends StatelessWidget {
  const _LogoGlyph({
    required this.size,
    required this.foreground,
    required this.accent,
  });

  final double size;
  final Color foreground;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'G',
            style: TextStyle(
              fontSize: size * 0.82,
              fontWeight: FontWeight.w800,
              color: foreground,
              height: 1,
            ),
          ),
          Positioned(
            right: size * 0.04,
            bottom: size * 0.08,
            child: Container(
              width: size * 0.16,
              height: size * 0.16,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(size * 0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
