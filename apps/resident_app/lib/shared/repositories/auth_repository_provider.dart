import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_repository.dart';
import 'secure_storage_auth_repository.dart';

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
    resetOnError: true,
  ),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => _secureStorage,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => SecureStorageAuthRepository(
    storage: ref.watch(secureStorageProvider),
  ),
);
