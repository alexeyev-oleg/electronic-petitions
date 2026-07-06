class LocationConfirmPayload {
  const LocationConfirmPayload({
    required this.locationLabel,
    this.latitude,
    this.longitude,
    required this.geoMismatch,
  });

  final String locationLabel;
  final double? latitude;
  final double? longitude;
  final bool geoMismatch;
}
