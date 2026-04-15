import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/router.dart';
import 'session_controller.dart';

class DeepLinkHandler {
  DeepLinkHandler(this.ref);
  final Ref ref;
  final _links = AppLinks();
  StreamSubscription<Uri>? _sub;

  Future<void> start() async {
    final initial = await _links.getInitialLink();
    if (initial != null) await _route(initial);
    _sub = _links.uriLinkStream.listen(_route);
  }

  void dispose() => _sub?.cancel();

  Future<void> _route(Uri uri) async {
    if (uri.scheme != 'tiide') return;
    if (uri.host == 'session' && uri.pathSegments.firstOrNull == 'start') {
      await ref.read(sessionControllerProvider).startSession();
      router.go('/active');
    }
  }
}

final deepLinkProvider = Provider<DeepLinkHandler>((ref) {
  final h = DeepLinkHandler(ref);
  ref.onDispose(h.dispose);
  return h;
});
