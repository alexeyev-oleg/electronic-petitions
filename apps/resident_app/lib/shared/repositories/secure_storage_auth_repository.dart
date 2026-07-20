import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/app_user.dart';
import '../models/identity_level.dart';
import '../models/kyc_status.dart';
import '../models/session_tier.dart';
import 'auth_flow_exception.dart';
import 'auth_repository.dart';

class SecureStorageAuthRepository implements AuthRepository {
  SecureStorageAuthRepository({
    required FlutterSecureStorage storage,
    this.delay = const Duration(milliseconds: 600),
  }) : _storage = storage;

  final FlutterSecureStorage _storage;
  final Duration delay;

  static const _sessionKey = 'resident_app_session';
  static const mockOtpCode = '123456';

  String? _pendingPhoneNumber;

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final raw = await _storage
          .read(key: _sessionKey)
          .timeout(const Duration(seconds: 5));
      if (raw == null || raw.isEmpty) {
        return null;
      }

      return AppUser.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);

    final existing = await getCurrentUser();
    if (existing != null && existing.email == email.trim()) {
      return existing;
    }

    final user = AppUser(
      id: 'mock-user-1',
      email: email.trim(),
      emailVerified: true,
    );
    await _persist(user);
    return user;
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);

    final user = AppUser(
      id: 'mock-user-${DateTime.now().millisecondsSinceEpoch}',
      email: email.trim(),
      emailVerified: false,
    );
    await _persist(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _pendingPhoneNumber = null;
    await _storage.delete(key: _sessionKey);
  }

  @override
  Future<void> sendPhoneOtp({required String phoneNumber}) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    _pendingPhoneNumber = _normalizePhone(phoneNumber);
  }

  @override
  Future<AppUser> verifyPhoneOtp({
    required String phoneNumber,
    required String otpCode,
  }) async {
    await Future<void>.delayed(delay);
    _assertOtp(otpCode);

    final current = await _requireCurrentUser();
    final normalizedPhone = _normalizePhone(phoneNumber);
    if (_pendingPhoneNumber != null && _pendingPhoneNumber != normalizedPhone) {
      throw const AuthFlowException('phone_mismatch');
    }

    final upgraded = current.copyWith(
      phoneNumber: normalizedPhone,
      phoneVerified: true,
      identityLevel: current.kycStatus == KycStatus.approved
          ? IdentityLevel.identityVerified
          : IdentityLevel.phoneVerified,
      sessionTier: SessionTier.secure,
    );
    _pendingPhoneNumber = null;
    await _persist(upgraded);
    return upgraded;
  }

  @override
  Future<AppUser> startKycSession() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final current = await _requireCurrentUser();
    if (!current.phoneVerified) {
      throw const AuthFlowException('phone_required');
    }

    final updated = current.copyWith(kycStatus: KycStatus.pending);
    await _persist(updated);
    return updated;
  }

  @override
  Future<AppUser> submitMockKyc({
    required String documentNumber,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final current = await _requireCurrentUser();
    if (!current.phoneVerified) {
      throw const AuthFlowException('phone_required');
    }

    final trimmed = documentNumber.trim();
    if (trimmed.length < 5) {
      throw const AuthFlowException('document_invalid');
    }

    final updated = current.copyWith(
      kycStatus: KycStatus.approved,
      identityLevel: IdentityLevel.identityVerified,
      sessionTier: SessionTier.secure,
    );
    await _persist(updated);
    return updated;
  }

  @override
  Future<AppUser> confirmSensitiveAction({required String otpCode}) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    _assertOtp(otpCode);

    final current = await _requireCurrentUser();
    if (!current.canSignPetitions) {
      throw const AuthFlowException('kyc_required');
    }
    if (!current.hasSecureSession) {
      throw const AuthFlowException('secure_session_required');
    }

    return current;
  }

  @override
  Future<AppUser> saveUser(AppUser user) async {
    await _persist(user);
    return user;
  }

  Future<AppUser> _requireCurrentUser() async {
    final current = await getCurrentUser();
    if (current == null) {
      throw const AuthFlowException('not_authenticated');
    }
    return current;
  }

  void _assertOtp(String otpCode) {
    if (otpCode.trim() != mockOtpCode) {
      throw const AuthFlowException('otp_invalid');
    }
  }

  String _normalizePhone(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '').trim();
  }

  Future<void> _persist(AppUser user) async {
    await _storage.write(
      key: _sessionKey,
      value: jsonEncode(user.toJson()),
    );
  }
}
