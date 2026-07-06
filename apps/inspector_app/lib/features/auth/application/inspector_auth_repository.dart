import '../../shared/models/inspector_user.dart';

abstract class InspectorAuthRepository {
  Future<InspectorUser?> getCurrentUser();
  Future<InspectorUser> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
