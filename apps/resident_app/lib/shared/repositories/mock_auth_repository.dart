import 'dart:async';

import '../models/app_user.dart';
import '../models/identity_level.dart';
import '../models/kyc_status.dart';
import '../models/session_tier.dart';
import 'auth_flow_exception.dart';
import 'auth_repository.dart';
import 'secure_storage_auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  MockAuthRepository({
    this.delay = const Duration(milliseconds: 600),
  });

  final Duration delay;
  AppUser? _currentUser;
  String? _pendingPhoneNumber;

  @override
  Future<AppUser?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);
    _currentUser = AppUser(
      id: 'mock-user-1',
      email: email.trim(),
      emailVerified: true,
    );
    return _currentUser!;
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);
    _currentUser = AppUser(
      id: 'mock-user-1',
      email: email.trim(),
    );
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _currentUser = null;
    _pendingPhoneNumber = null;
  }

  @override
  Future<void> sendPhoneOtp({required String phoneNumber}) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    _pendingPhoneNumber = phoneNumber.trim();
  }

  @override
  Future<AppUser> verifyPhoneOtp({
    required String phoneNumber,
    required String otpCode,
  }) async {
    await Future<void>.delayed(delay);
    if (otpCode.trim() != SecureStorageAuthRepository.mockOtpCode) {
      throw const AuthFlowException('otp_invalid');
    }
    _currentUser = (_currentUser ?? AppUser(id: 'mock-user-1', email: 'demo@example.com'))
        .copyWith(
      phoneNumber: phoneNumber.trim(),
      phoneVerified: true,
      identityLevel: IdentityLevel.phoneVerified,
      sessionTier: SessionTier.secure,
    );
    return _currentUser!;
  }

  @override
  Future<AppUser> startKycSession() async {
    _currentUser = _requireUser().copyWith(kycStatus: KycStatus.pending);
    return _currentUser!;
  }

  @override
  Future<AppUser> submitMockKyc({required String documentNumber}) async {
    if (documentNumber.trim().length < 5) {
      throw const AuthFlowException('document_invalid');
    }
    _currentUser = _requireUser().copyWith(
      kycStatus: KycStatus.approved,
      identityLevel: IdentityLevel.identityVerified,
      sessionTier: SessionTier.secure,
    );
    return _currentUser!;
  }

  @override
  Future<AppUser> confirmSensitiveAction({required String otpCode}) async {
    if (otpCode.trim() != SecureStorageAuthRepository.mockOtpCode) {
      throw const AuthFlowException('otp_invalid');
    }
    return _requireUser();
  }

  @override
  Future<AppUser> saveUser(AppUser user) async {
    _currentUser = user;
    return user;
  }

  AppUser _requireUser() {
    final user = _currentUser;
    if (user == null) {
      throw const AuthFlowException('not_authenticated');
    }
    return user;
  }
}
