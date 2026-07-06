import 'identity_level.dart';
import 'kyc_status.dart';
import 'session_tier.dart';

class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    this.emailVerified = true,
    this.phoneNumber,
    this.phoneVerified = false,
    this.identityLevel = IdentityLevel.betaBasic,
    this.kycStatus = KycStatus.notStarted,
    this.sessionTier = SessionTier.beta,
  });

  final String id;
  final String email;
  final bool emailVerified;
  final String? phoneNumber;
  final bool phoneVerified;
  final IdentityLevel identityLevel;
  final KycStatus kycStatus;
  final SessionTier sessionTier;

  bool get hasSecureSession =>
      sessionTier == SessionTier.secure && phoneVerified;

  bool get canSignPetitions => kycStatus == KycStatus.approved;

  bool get needsPhoneVerification => !phoneVerified;

  bool get needsKycVerification =>
      phoneVerified && kycStatus != KycStatus.approved;

  AppUser copyWith({
    String? id,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
    bool? phoneVerified,
    IdentityLevel? identityLevel,
    KycStatus? kycStatus,
    SessionTier? sessionTier,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      identityLevel: identityLevel ?? this.identityLevel,
      kycStatus: kycStatus ?? this.kycStatus,
      sessionTier: sessionTier ?? this.sessionTier,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'emailVerified': emailVerified,
      'phoneNumber': phoneNumber,
      'phoneVerified': phoneVerified,
      'identityLevel': identityLevel.name,
      'kycStatus': kycStatus.name,
      'sessionTier': sessionTier.name,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool? ?? true,
      phoneNumber: json['phoneNumber'] as String?,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
      identityLevel: _identityLevelFromJson(json['identityLevel']),
      kycStatus: _kycStatusFromJson(json['kycStatus']),
      sessionTier: _sessionTierFromJson(json['sessionTier']),
    );
  }

  static IdentityLevel _identityLevelFromJson(Object? value) {
    if (value is! String) {
      return IdentityLevel.betaBasic;
    }
    return IdentityLevel.values.asNameMap()[value] ??
        IdentityLevel.betaBasic;
  }

  static KycStatus _kycStatusFromJson(Object? value) {
    if (value is! String) {
      return KycStatus.notStarted;
    }
    return KycStatus.values.asNameMap()[value] ?? KycStatus.notStarted;
  }

  static SessionTier _sessionTierFromJson(Object? value) {
    if (value is! String) {
      return SessionTier.beta;
    }
    return SessionTier.values.asNameMap()[value] ?? SessionTier.beta;
  }
}
