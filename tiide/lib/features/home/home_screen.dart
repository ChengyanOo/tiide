import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/session_controller.dart';
import '../../core/theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(activeSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('tiide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () => context.push('/sessions'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(TiideSpacing.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'make your effort seen',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: TiideSpacing.xl),
              active.when(
                data: (s) => s == null
                    ? _StartButton(
                        onPressed: () async {
                          await ref
                              .read(sessionControllerProvider)
                              .startSession();
                          if (context.mounted) context.push('/active');
                        },
                      )
                    : _ResumeButton(onPressed: () => context.push('/active')),
                loading: () =>
                    const CircularProgressIndicator(color: TiideColors.accent),
                error: (e, _) => Text('$e'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: TiideColors.accent,
          foregroundColor: Colors.black,
          shape: const CircleBorder(),
        ),
        onPressed: onPressed,
        child: const Text('START',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 2)),
      ),
    );
  }
}

class _ResumeButton extends StatelessWidget {
  const _ResumeButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('session in progress',
            style: TextStyle(color: TiideColors.silver)),
        const SizedBox(height: TiideSpacing.m),
        FilledButton(onPressed: onPressed, child: const Text('RESUME')),
      ],
    );
  }
}
