import 'package:flutter/material.dart';

import 'gesher_brand_mark.dart';

class AppBrandHeader extends StatelessWidget {
  const AppBrandHeader({
    super.key,
    this.subtitle,
    this.compact = false,
  });

  final String? subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return GesherBrandMark(
      size: compact ? 64 : 80,
      tagline: subtitle,
    );
  }
}
