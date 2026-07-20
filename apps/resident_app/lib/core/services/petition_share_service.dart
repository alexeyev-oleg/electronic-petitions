import 'package:url_launcher/url_launcher.dart';

import '../constants/app_links.dart';

enum PetitionShareChannel {
  email,
  whatsapp,
  telegram,
}

abstract final class PetitionShareService {
  static String shareText({
    required String title,
    required String petitionId,
  }) {
    final link = AppLinks.publicInitiativeUrl(petitionId);
    return '$title\n\n$link';
  }

  static Future<bool> share({
    required PetitionShareChannel channel,
    required String title,
    required String petitionId,
  }) async {
    final link = AppLinks.publicInitiativeUrl(petitionId);
    final body = shareText(title: title, petitionId: petitionId);
    final uri = switch (channel) {
      PetitionShareChannel.email => Uri(
          scheme: 'mailto',
          queryParameters: {
            'subject': title,
            'body': body,
          },
        ),
      PetitionShareChannel.whatsapp => Uri.parse(
          'https://wa.me/?text=${Uri.encodeComponent(body)}',
        ),
      PetitionShareChannel.telegram => Uri.parse(
          'https://t.me/share/url?url=${Uri.encodeComponent(link)}'
          '&text=${Uri.encodeComponent(title)}',
        ),
    };

    if (!await canLaunchUrl(uri)) {
      return false;
    }
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
