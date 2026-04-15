import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/router.dart';
import 'core/theme.dart';

void main() {
  runApp(const ProviderScope(child: TiideApp()));
}

class TiideApp extends StatelessWidget {
  const TiideApp({super.key});

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
