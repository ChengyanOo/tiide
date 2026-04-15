import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/router.dart';
import 'core/background_service.dart';
import 'core/deep_links.dart';
import 'core/health_service.dart';
import 'core/location_service.dart';
import 'core/notifications.dart';
import 'core/permissions.dart';
import 'core/session_controller.dart';
import 'core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance
      .init(onBackground: notificationBackgroundHandler);
  await initBackgroundService();

  final prefs = await SharedPreferences.getInstance();

  // S4: Request OS-level permissions if user opted in.
  final permPrefs = PermissionPrefs(prefs);
  if (permPrefs.healthOptIn) {
    await HealthService.instance.requestPermissions();
  }
  if (permPrefs.geoOptIn) {
    await LocationService.instance.requestPermissions();
  }

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const TiideApp(),
    ),
  );
}

class TiideApp extends ConsumerStatefulWidget {
  const TiideApp({super.key});

  @override
  ConsumerState<TiideApp> createState() => _TiideAppState();
}

class _TiideAppState extends ConsumerState<TiideApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(deepLinkProvider).start();
      NotificationService.instance.onSelect.listen(_handleNotif);
    });
  }

  Future<void> _handleNotif(NotificationResponse r) async {
    final id = r.payload;
    if (id == null) return;
    final controller = ref.read(sessionControllerProvider);
    switch (r.actionId) {
      case kActionExtend5:
        await controller.extend(id, minutes: 5);
      case kActionSaveTag:
      case null:
        router.go('/active');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'tiide',
      debugShowCheckedModeBanner: false,
      theme: buildTiideTheme(),
      routerConfig: router,
    );
  }
}
