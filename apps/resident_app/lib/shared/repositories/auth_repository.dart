import '../models/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();

  Future<AppUser> signIn({
    required String email,
    required String password,
  });

  Future<AppUser> signUp({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendPhoneOtp({required String phoneNumber});

  Future<AppUser> verifyPhoneOtp({
    required String phoneNumber,
    required String otpCode,
  });

  Future<AppUser> startKycSession();

  Future<AppUser> submitMockKyc({
    required String documentNumber,
  });

  Future<AppUser> confirmSensitiveAction({required String otpCode});

  Future<AppUser> saveUser(AppUser user);
}
