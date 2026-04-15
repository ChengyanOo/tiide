import 'dart:async';
import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'notifications.dart';

bool get _supported =>
    !kIsWeb && (Platform.isAndroid || Platform.isIOS);

const kBgTaskStartSession = 'start_session';
const kBgTaskEndSession = 'end_session';
const kBgEventHeartbeat = 'heartbeat';

Future<void> initBackgroundService() async {
  if (!_supported) return;
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: _onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: kActiveChannelId,
      initialNotificationTitle: 'tiide — session active',
      initialNotificationContent: 'ride it out.',
      foregroundServiceNotificationId: kEndNotifId + 1,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: _onStart,
      onBackground: _onIosBackground,
      autoStart: false,
    ),
  );
}

@pragma('vm:entry-point')
bool _onIosBackground(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void _onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  service.on('stop').listen((_) => service.stopSelf());
  Timer.periodic(const Duration(seconds: 30), (_) {
    service.invoke(kBgEventHeartbeat, {'ts': DateTime.now().toIso8601String()});
  });
}
