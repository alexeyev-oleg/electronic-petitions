class InspectorAuthException implements Exception {
  const InspectorAuthException(this.code);

  final String code;
}
