abstract final class AppLinks {
  static const publicWebUrl =
      'https://alexeyev-oleg.github.io/electronic-petitions/';

  /// Public initiative page used for share links and QR codes.
  static String publicInitiativeUrl(String petitionId) {
    final base = publicWebUrl.endsWith('/')
        ? publicWebUrl.substring(0, publicWebUrl.length - 1)
        : publicWebUrl;
    return '$base/initiative.html?id=${Uri.encodeComponent(petitionId)}';
  }
}
