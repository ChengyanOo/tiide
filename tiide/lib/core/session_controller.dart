import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';

import '../app/providers.dart';
import '../data/db/database.dart';
import '../data/repo/enrichment_repo.dart';
import '../data/repo/session_repo.dart';
import 'health_service.dart';
import 'location_service.dart';
import 'notifications.dart';
import 'permissions.dart';

bool get _mobile =>
    !kIsWeb && (Platform.isAndroid || Platform.isIOS);

const kWidgetActiveKey = 'tiide.activeSessionId';
const kWidgetStartedAtKey = 'tiide.startedAt';
const kWidgetPlannedMinKey = 'tiide.plannedMin';

class SessionController {
  SessionController(this.repo, this.enrichmentRepo, this.permPrefs);
  final SessionRepo repo;
  final EnrichmentRepo enrichmentRepo;
  final PermissionPrefs permPrefs;

  Future<Session> startSession({int plannedMin = 15}) async {
    final existing = await repo.activeSession();
    if (existing != null) {
      await _publishWidget(existing);
      return existing;
    }
    final s = await repo.create(plannedDurationMin: plannedMin);
    await _scheduleEnd(s);
    await _publishWidget(s);
    await _startBgService();
    await NotificationService.instance.showActive(sessionId: s.id);

    // S4: Capture pre-session biometric + start location.
    await _captureStartEnrichment(s);

    return s;
  }

  /// Max allowed extensions per session.
  static const maxExtensions = 3;

  Future<Session> extend(String id, {int minutes = 5}) async {
    final current = await repo.byId(id);
    if (current != null && current.extensionCount >= maxExtensions) {
      return current;
    }
    final s = await repo.extend(id: id, minutes: minutes);
    await _scheduleEnd(s);
    return s;
  }

  Future<void> finalize({
    required String id,
    required int actualDurationMin,
    required List<String> tagIds,
    String outcome = 'saved',
  }) async {
    await repo.finalize(
      id: id,
      actualDurationMin: actualDurationMin,
      tagIds: tagIds,
      outcome: outcome,
    );
    await NotificationService.instance.cancelEnd();
    await NotificationService.instance.dismissActive();
    await _clearWidget();
    await _stopBgService();

    // S4: Capture end-session biometric + end location.
    await _captureEndEnrichment(id);
  }

  // ---- S4: Enrichment capture ----

  Future<void> _captureStartEnrichment(Session s) async {
    // Health: fetch HR/HRV for [t0-5m, t0].
    if (permPrefs.healthOptIn && platformSupportsEnrichment) {
      final pre = await HealthService.instance.fetchSamples(
        start: s.startedAt.subtract(const Duration(minutes: 5)),
        end: s.startedAt,
      );
      if (!pre.isEmpty) {
        await enrichmentRepo.saveSnapshot(sessionId: s.id, pre: pre);
      }
    }

    // Geo: capture start point.
    if (permPrefs.geoOptIn && platformSupportsEnrichment) {
      final point = await LocationService.instance.capture();
      if (point != null) {
        await enrichmentRepo.saveGeoPoint(
          sessionId: s.id,
          kind: 'start',
          point: point,
        );
      }
    }
  }

  Future<void> _captureEndEnrichment(String sessionId) async {
    final s = await repo.byId(sessionId);
    if (s == null) return;

    final endTime = s.endedAt ?? DateTime.now();

    // Health: fetch HR/HRV for [tEnd, tEnd+5m].
    if (permPrefs.healthOptIn && platformSupportsEnrichment) {
      final during = await HealthService.instance.fetchSamples(
        start: endTime,
        end: endTime.add(const Duration(minutes: 5)),
      );
      if (!during.isEmpty) {
        await enrichmentRepo.saveSnapshot(sessionId: sessionId, during: during);
      }
    }

    // Geo: capture end point.
    if (permPrefs.geoOptIn && platformSupportsEnrichment) {
      final point = await LocationService.instance.capture();
      if (point != null) {
        await enrichmentRepo.saveGeoPoint(
          sessionId: sessionId,
          kind: 'end',
          point: point,
        );
      }
    }
  }

  // ---- Existing helpers ----

  Future<void> _scheduleEnd(Session s) async {
    final fire = s.startedAt.add(Duration(minutes: s.plannedDurationMin));
    await NotificationService.instance
        .scheduleEnd(sessionId: s.id, fireAt: fire);
  }

  Future<void> _publishWidget(Session s) async {
    if (!_mobile) return;
    await HomeWidget.saveWidgetData(kWidgetActiveKey, s.id);
    await HomeWidget.saveWidgetData(
        kWidgetStartedAtKey, s.startedAt.toIso8601String());
    await HomeWidget.saveWidgetData(kWidgetPlannedMinKey, s.plannedDurationMin);
    await HomeWidget.updateWidget(
      iOSName: 'TiideWidget',
      androidName: 'TiideGlanceReceiver',
    );
  }

  Future<void> _clearWidget() async {
    if (!_mobile) return;
    await HomeWidget.saveWidgetData<String?>(kWidgetActiveKey, null);
    await HomeWidget.updateWidget(
      iOSName: 'TiideWidget',
      androidName: 'TiideGlanceReceiver',
    );
  }

  Future<void> _startBgService() async {
    if (!_mobile) return;
    final svc = FlutterBackgroundService();
    if (!(await svc.isRunning())) await svc.startService();
  }

  Future<void> _stopBgService() async {
    if (!_mobile) return;
    FlutterBackgroundService().invoke('stop');
  }
}

final sessionControllerProvider = Provider<SessionController>((ref) {
  return SessionController(
    ref.watch(sessionRepoProvider),
    ref.watch(enrichmentRepoProvider),
    ref.watch(permissionPrefsProvider),
  );
});
