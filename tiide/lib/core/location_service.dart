import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

/// Captures a single coarse location point. No continuous tracking.
class LocationService {
  LocationService._();
  static final instance = LocationService._();

  /// Request location permissions. Returns true if granted.
  Future<bool> requestPermissions() async {
    if (!_supported) return false;
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) return false;

      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      return perm == LocationPermission.whileInUse ||
          perm == LocationPermission.always;
    } catch (_) {
      return false;
    }
  }

  /// Get current position (coarse). Returns null on failure.
  Future<GeoPoint?> capture() async {
    if (!_supported) return null;
    try {
      final perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return null;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low, // coarse only
          timeLimit: Duration(seconds: 10),
        ),
      );
      return GeoPoint(
        lat: pos.latitude,
        lng: pos.longitude,
        accuracyM: pos.accuracy,
      );
    } catch (_) {
      return null;
    }
  }
}

class GeoPoint {
  final double lat;
  final double lng;
  final double accuracyM;
  GeoPoint({required this.lat, required this.lng, required this.accuracyM});
}
