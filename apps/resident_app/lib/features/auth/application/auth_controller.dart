import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/app_user.dart';
import '../../../shared/repositories/auth_flow_exception.dart';
import '../../../shared/repositories/auth_repository.dart';
import '../../../shared/repositories/auth_repository_provider.dart';
import '../../../shared/repositories/secure_storage_auth_repository.dart';

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(
    repository: ref.watch(authRepositoryProvider),
  );
});

class AuthController extends ChangeNotifier {
  AuthController({
    required AuthRepository repository,
  }) : _repository = repository;

  final AuthRepository _repository;

  AppUser? _currentUser;
  bool _isLoading = true;
  String? _errorMessage;
  String? _flowMessage;
  Future<void>? _initFuture;

  AppUser? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get flowMessage => _flowMessage;
  String get mockOtpHint => SecureStorageAuthRepository.mockOtpCode;

  Future<void> ensureInitialized() {
    return _initFuture ??= _initialize();
  }

  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await _repository.getCurrentUser();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _runAuthAction(
      () => _repository.signIn(email: email, password: password),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _runAuthAction(
      () => _repository.signUp(email: email, password: password),
    );
  }

  Future<void> signOut() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.signOut();
      _currentUser = null;
    } catch (_) {
      _errorMessage = 'Unable to sign out right now.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendPhoneOtp({required String phoneNumber}) async {
    return _runFlowAction(() async {
      await _repository.sendPhoneOtp(phoneNumber: phoneNumber);
      _flowMessage = 'otp_sent';
    });
  }

  Future<bool> verifyPhoneOtp({
    required String phoneNumber,
    required String otpCode,
  }) async {
    return _runFlowAction(() async {
      _currentUser = await _repository.verifyPhoneOtp(
        phoneNumber: phoneNumber,
        otpCode: otpCode,
      );
      _flowMessage = 'phone_verified';
    });
  }

  Future<bool> startKycSession() async {
    return _runFlowAction(() async {
      _currentUser = await _repository.startKycSession();
      _flowMessage = 'kyc_started';
    });
  }

  Future<bool> submitMockKyc({required String documentNumber}) async {
    return _runFlowAction(() async {
      _currentUser = await _repository.submitMockKyc(
        documentNumber: documentNumber,
      );
      _flowMessage = 'kyc_approved';
    });
  }

  Future<bool> confirmSensitiveAction({required String otpCode}) async {
    return _runFlowAction(() async {
      _currentUser = await _repository.confirmSensitiveAction(
        otpCode: otpCode,
      );
      _flowMessage = 'sensitive_action_confirmed';
    });
  }

  void clearFlowState() {
    _errorMessage = null;
    _flowMessage = null;
    notifyListeners();
  }

  Future<void> _runAuthAction(
    Future<AppUser> Function() action,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await action();
    } catch (_) {
      _errorMessage = 'Unable to complete authentication right now.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> _runFlowAction(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    _flowMessage = null;
    notifyListeners();

    try {
      await action();
      return true;
    } on AuthFlowException catch (error) {
      _errorMessage = error.code;
      return false;
    } catch (_) {
      _errorMessage = 'flow_failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
