import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/models/inspector_user.dart';
import '../../../shared/providers/shared_preferences_provider.dart';
import 'inspector_auth_exception.dart';
import 'inspector_auth_repository.dart';

class MockInspectorCredentials {
  static const email = 'inspector@haifa.mock';
  static const password = 'inspector123';
  static const sessionKey = 'mock_inspector_session_v1';
}

final inspectorAuthRepositoryProvider = Provider<InspectorAuthRepository>(
  (ref) => MockInspectorAuthRepository(ref.watch(sharedPreferencesProvider)),
);

class MockInspectorAuthRepository implements InspectorAuthRepository {
  MockInspectorAuthRepository(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<InspectorUser?> getCurrentUser() async {
    final raw = _preferences.getString(MockInspectorCredentials.sessionKey);
    if (raw == null) {
      return null;
    }

    return InspectorUser.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  @override
  Future<InspectorUser> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail != MockInspectorCredentials.email ||
        password != MockInspectorCredentials.password) {
      throw const InspectorAuthException('invalid_credentials');
    }

    final user = InspectorUser(
      id: 'inspector-mock-1',
      email: MockInspectorCredentials.email,
      fullName: 'Municipal Inspector (Mock)',
      badgeId: 'INS-1042',
      role: 'inspector',
    );
    await _preferences.setString(
      MockInspectorCredentials.sessionKey,
      jsonEncode(user.toJson()),
    );
    return user;
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    await _preferences.remove(MockInspectorCredentials.sessionKey);
  }
}
