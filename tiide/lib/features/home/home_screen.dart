import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/session_controller.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../session/retro_edit_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _retroShown = false;

  @override
  Widget build(BuildContext context) {
    final active = ref.watch(activeSessionProvider);

    // S3.3: detect orphaned session and show retro-edit sheet.
    active.whenData((s) {
      if (s != null && !_retroShown) {
        _maybeShowRetroEdit(context, s);
      }
    });

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
                data: (s) {
                  if (s == null) {
                    return _StartButton(
                      onPressed: () async {
                        await ref
                            .read(sessionControllerProvider)
                            .startSession();
                        if (context.mounted) context.push('/active');
                      },
                    );
                  }
                  // If it's an orphaned session (past grace), retro-edit
                  // handles it. Otherwise show resume.
                  if (_isOrphaned(s)) {
                    return _StartButton(
                      onPressed: () async {
                        await ref
                            .read(sessionControllerProvider)
                            .startSession();
                        if (context.mounted) context.push('/active');
                      },
                    );
                  }
                  return _ResumeButton(
                      onPressed: () => context.push('/active'));
                },
                loading: () => const CircularProgressIndicator(
                    color: TiideColors.accent),
                error: (e, _) => Text('$e'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// An active session is "orphaned" when now > startedAt + planned + 1 h.
  bool _isOrphaned(Session s) {
    final grace = s.startedAt
        .add(Duration(minutes: s.plannedDurationMin))
        .add(const Duration(hours: 1));
    return DateTime.now().isAfter(grace);
  }

  void _maybeShowRetroEdit(BuildContext context, Session s) {
    if (!_isOrphaned(s)) return;
    _retroShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        builder: (_) => RetroEditSheet(session: s),
      );
    });
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
