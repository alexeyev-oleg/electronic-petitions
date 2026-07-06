class MockIdHelper {
  static String nextId(String prefix, Iterable<String> existingIds) {
    var max = 0;
    for (final id in existingIds) {
      if (!id.startsWith(prefix)) continue;
      final value = int.tryParse(id.substring(prefix.length));
      if (value != null && value > max) {
        max = value;
      }
    }
    return '$prefix${max + 1}';
  }
}
