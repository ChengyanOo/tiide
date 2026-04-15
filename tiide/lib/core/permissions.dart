import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool get _mobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

const _kHealthOptIn = 'perm.health.optIn';
const _kGeoOptIn = 'perm.geo.optIn';
const _kPermExplainerShown = 'perm.explainerShown';
const _kOnboardingComplete = 'onboarding.complete';

/// Granular opt-in state for health and location capture.
class PermissionPrefs {
  PermissionPrefs(this._prefs);
  final SharedPreferences _prefs;

  bool get healthOptIn => _prefs.getBool(_kHealthOptIn) ?? false;
  bool get geoOptIn => _prefs.getBool(_kGeoOptIn) ?? false;
  bool get explainerShown => _prefs.getBool(_kPermExplainerShown) ?? false;
  bool get onboardingComplete => _prefs.getBool(_kOnboardingComplete) ?? false;

  Future<void> setHealthOptIn(bool v) => _prefs.setBool(_kHealthOptIn, v);
  Future<void> setGeoOptIn(bool v) => _prefs.setBool(_kGeoOptIn, v);
  Future<void> setExplainerShown() => _prefs.setBool(_kPermExplainerShown, true);
  Future<void> setOnboardingComplete() => _prefs.setBool(_kOnboardingComplete, true);
  Future<void> resetOnboarding() => _prefs.setBool(_kOnboardingComplete, false);
}

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in main with SharedPreferences.getInstance()');
});

final permissionPrefsProvider = Provider<PermissionPrefs>((ref) {
  return PermissionPrefs(ref.watch(sharedPrefsProvider));
});

/// Whether the platform supports biometric/geo at all.
bool get platformSupportsEnrichment => _mobile;
