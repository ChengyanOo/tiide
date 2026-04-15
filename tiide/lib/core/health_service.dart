import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

/// Wraps the `health` package to fetch HR / HRV samples around a session.
class HealthService {
  HealthService._();
  static final instance = HealthService._();

  final _health = Health();
  bool _configured = false;

  static const _types = [
    HealthDataType.HEART_RATE,
    HealthDataType.HEART_RATE_VARIABILITY_SDNN,
  ];

  static final _permissions = _types.map((_) => HealthDataAccess.READ).toList();

  /// Request health permissions. Returns true if authorized.
  Future<bool> requestPermissions() async {
    if (!_supported) return false;
    try {
      await _health.configure();
      _configured = true;
      return await _health.requestAuthorization(_types,
          permissions: _permissions);
    } catch (_) {
      return false;
    }
  }

  /// Fetch HR + HRV samples in [start, end]. Returns raw data points.
  Future<HealthSnapshot> fetchSamples({
    required DateTime start,
    required DateTime end,
  }) async {
    if (!_supported || !_configured) return HealthSnapshot.empty();
    try {
      final data = await _health.getHealthDataFromTypes(
        types: _types,
        startTime: start,
        endTime: end,
      );
      final hr = <HealthSample>[];
      final hrv = <HealthSample>[];
      for (final d in data) {
        final val = (d.value as NumericHealthValue).numericValue.toDouble();
        final sample = HealthSample(ts: d.dateFrom, value: val);
        if (d.type == HealthDataType.HEART_RATE) {
          hr.add(sample);
        } else if (d.type == HealthDataType.HEART_RATE_VARIABILITY_SDNN) {
          hrv.add(sample);
        }
      }
      return HealthSnapshot(hrSamples: hr, hrvSamples: hrv);
    } catch (_) {
      return HealthSnapshot.empty();
    }
  }
}

class HealthSample {
  final DateTime ts;
  final double value;
  HealthSample({required this.ts, required this.value});
}

class HealthSnapshot {
  final List<HealthSample> hrSamples;
  final List<HealthSample> hrvSamples;
  HealthSnapshot({required this.hrSamples, required this.hrvSamples});
  factory HealthSnapshot.empty() =>
      HealthSnapshot(hrSamples: [], hrvSamples: []);

  double? get hrAvg =>
      hrSamples.isEmpty ? null : hrSamples.map((s) => s.value).reduce((a, b) => a + b) / hrSamples.length;
  double? get hrvAvg =>
      hrvSamples.isEmpty ? null : hrvSamples.map((s) => s.value).reduce((a, b) => a + b) / hrvSamples.length;
  bool get isEmpty => hrSamples.isEmpty && hrvSamples.isEmpty;
}
