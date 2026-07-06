enum IdentityLevel {
  betaBasic,
  phoneVerified,
  identityVerified,
}

extension IdentityLevelLabels on IdentityLevel {
  String get storageName => name;
}
