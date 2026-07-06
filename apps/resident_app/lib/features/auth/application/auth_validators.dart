class AuthValidators {
  static String? email(String? value, dynamic l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.emailRequired as String;
    }
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailPattern.hasMatch(trimmed)) {
      return l10n.emailInvalid as String;
    }
    return null;
  }

  static String? password(
    String? value,
    dynamic l10n, {
    required bool isSignUp,
  }) {
    final trimmed = value ?? '';
    if (trimmed.isEmpty) {
      return l10n.passwordRequired as String;
    }
    if (isSignUp && trimmed.length < 8) {
      return l10n.passwordTooShort as String;
    }
    return null;
  }

  static String? phoneNumber(String? value, dynamic l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.phoneRequired as String;
    }
    final digits = trimmed.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length < 9) {
      return l10n.phoneInvalid as String;
    }
    return null;
  }

  static String? otpCode(String? value, dynamic l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.otpRequired as String;
    }
    if (trimmed.length != 6 || int.tryParse(trimmed) == null) {
      return l10n.otpInvalid as String;
    }
    return null;
  }

  static String? documentNumber(String? value, dynamic l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.documentNumberRequired as String;
    }
    if (trimmed.length < 5) {
      return l10n.documentNumberInvalid as String;
    }
    return null;
  }
}
