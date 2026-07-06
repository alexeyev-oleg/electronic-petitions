import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/inspector_user.dart';
import 'inspector_auth_exception.dart';
import 'inspector_auth_repository.dart';
import 'mock_inspector_auth_repository.dart';

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(
    repository: ref.watch(inspectorAuthRepositoryProvider),
  );
});

class AuthController extends ChangeNotifier {
  AuthController({
    required InspectorAuthRepository repository,
  }) : _repository = repository;

  final InspectorAuthRepository _repository;

  InspectorUser? _currentUser;
  bool _isLoading = true;
  String? _errorMessage;
  Future<void>? _initFuture;

  InspectorUser? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get mockEmailHint => MockInspectorCredentials.email;
  String get mockPasswordHint => MockInspectorCredentials.password;

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

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _repository.signIn(
        email: email,
        password: password,
      );
      return true;
    } on InspectorAuthException catch (error) {
      _errorMessage = error.code;
      return false;
    } catch (_) {
      _errorMessage = 'unknown_error';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await _repository.signOut();
    _currentUser = null;

    _isLoading = false;
    notifyListeners();
  }
}
