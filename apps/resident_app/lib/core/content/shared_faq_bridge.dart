import 'dart:convert';

import 'package:flutter/services.dart';

class FaqEntry {
  const FaqEntry({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

/// Loads canonical FAQ from `assets/content/faq.json` (U9.3).
class SharedFaqBridge {
  static const assetPath = 'assets/content/faq.json';

  static Future<List<FaqEntry>> loadForLocale(String languageCode) async {
    final raw = await rootBundle.loadString(assetPath);
    final root = jsonDecode(raw) as Map<String, dynamic>;
    final items = root['items'] as List<dynamic>? ?? const [];

    return items
        .where((item) {
          final surfaces = item['surfaces'] as List<dynamic>? ?? const [];
          return surfaces.contains('mobile');
        })
        .map((item) {
          final text = item['text'] as Map<String, dynamic>;
          final block = (text[languageCode] ??
              text['en'] ??
              text['ru']) as Map<String, dynamic>;
          return FaqEntry(
            question: block['question'] as String,
            answer: block['answer'] as String,
          );
        })
        .toList();
  }
}
