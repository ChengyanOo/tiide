import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

bool get _supported =>
    !kIsWeb && (Platform.isAndroid || Platform.isIOS);

const kEndChannelId = 'tiide.session.end';
const kEndChannelName = 'Session end';
const kActiveChannelId = 'tiide.session.active';
const kActiveChannelName = 'Active session';

const kActionSaveTag = 'SAVE_TAG';
const kActionExtend5 = 'EXTEND_5';

const kEndNotifId = 42;

class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final plugin = FlutterLocalNotificationsPlugin();
  final _selectionController =
      StreamController<NotificationResponse>.broadcast();

  Stream<NotificationResponse> get onSelect => _selectionController.stream;

  Future<void> init({
    void Function(NotificationResponse)? onBackground,
  }) async {
    if (!_supported) return;
    tzdata.initializeTimeZones();

    const init = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    await plugin.initialize(
      init,
      onDidReceiveNotificationResponse: _selectionController.add,
      onDidReceiveBackgroundNotificationResponse: onBackground,
    );

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
      kEndChannelId,
      kEndChannelName,
      description: 'Fires when a session window ends.',
      importance: Importance.high,
    ));

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
      kActiveChannelId,
      kActiveChannelName,
      description: 'Persistent indicator for an active session.',
      importance: Importance.low,
    ));

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> scheduleEnd({
    required String sessionId,
    required DateTime fireAt,
  }) async {
    if (!_supported) return;
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        kEndChannelId,
        kEndChannelName,
        category: AndroidNotificationCategory.reminder,
        importance: Importance.high,
        priority: Priority.high,
        fullScreenIntent: false,
        actions: const <AndroidNotificationAction>[
          AndroidNotificationAction(
            kActionSaveTag,
            'Save & tag',
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            kActionExtend5,
            '+5 minutes',
            showsUserInterface: false,
          ),
        ],
      ),
      iOS: DarwinNotificationDetails(
        categoryIdentifier: 'TIIDE_END',
        presentAlert: true,
        presentSound: true,
      ),
    );

    await plugin.zonedSchedule(
      kEndNotifId,
      'Has the wave passed?',
      'Tap to save & tag, or add +5 minutes.',
      tz.TZDateTime.from(fireAt, tz.local),
      details,
      payload: sessionId,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelEnd() async {
    if (!_supported) return;
    await plugin.cancel(kEndNotifId);
  }

  Future<void> showActive({required String sessionId}) async {
    if (!_supported) return;
    await plugin.show(
      kEndNotifId + 1,
      'tiide — session active',
      'ride it out.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          kActiveChannelId,
          kActiveChannelName,
          ongoing: true,
          importance: Importance.low,
          priority: Priority.low,
          onlyAlertOnce: true,
        ),
      ),
      payload: sessionId,
    );
  }

  Future<void> dismissActive() async {
    if (!_supported) return;
    await plugin.cancel(kEndNotifId + 1);
  }
}

@pragma('vm:entry-point')
void notificationBackgroundHandler(NotificationResponse response) {}
