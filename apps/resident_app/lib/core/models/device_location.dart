class DeviceLocation {
  const DeviceLocation({
    required this.latitude,
    required this.longitude,
    required this.geoMismatch,
  });

  final double latitude;
  final double longitude;
  final bool geoMismatch;

  String get coordinatesLabel =>
      '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
}
