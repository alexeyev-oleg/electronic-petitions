import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../models/device_location.dart';

final locationCaptureServiceProvider = Provider<LocationCaptureService>(
  (_) => LocationCaptureService(),
);

class LocationCaptureService {
  static const double haifaMinLatitude = 32.70;
  static const double haifaMaxLatitude = 32.90;
  static const double haifaMinLongitude = 34.90;
  static const double haifaMaxLongitude = 35.10;

  bool isWithinHaifaRegion(double latitude, double longitude) {
    return latitude >= haifaMinLatitude &&
        latitude <= haifaMaxLatitude &&
        longitude >= haifaMinLongitude &&
        longitude <= haifaMaxLongitude;
  }

  Future<DeviceLocation?> captureCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return DeviceLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      geoMismatch: !isWithinHaifaRegion(
        position.latitude,
        position.longitude,
      ),
    );
  }
}
