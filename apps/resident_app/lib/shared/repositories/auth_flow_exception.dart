class AuthFlowException implements Exception {
  const AuthFlowException(this.code);

  final String code;
}
