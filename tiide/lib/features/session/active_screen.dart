import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../tag/tag_picker_sheet.dart';

class ActiveScreen extends ConsumerStatefulWidget {
  const ActiveScreen({super.key});

  @override
  ConsumerState<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends ConsumerState<ActiveScreen> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = ref.watch(activeSessionProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('session')),
      body: active.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: TiideColors.accent)),
        error: (e, _) => Center(child: Text('$e')),
        data: (s) {
          if (s == null) {
            return const Center(
                child: Text('no active session',
                    style: TextStyle(color: TiideColors.silver)));
          }
          return _ActiveBody(session: s);
        },
      ),
    );
  }
}

class _ActiveBody extends ConsumerWidget {
  const _ActiveBody({required this.session});
  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planned = Duration(minutes: session.plannedDurationMin);
    final elapsed = DateTime.now().difference(session.startedAt);
    final progress = (elapsed.inMilliseconds / planned.inMilliseconds)
        .clamp(0.0, 1.0)
        .toDouble();

    return Padding(
      padding: const EdgeInsets.all(TiideSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: TiideColors.midDark,
                      color: TiideColors.accent,
                    ),
                  ),
                  const Text('ride it out',
                      style: TextStyle(
                          color: TiideColors.silver,
                          fontSize: 16,
                          letterSpacing: 1.2)),
                ],
              ),
            ),
          ),
          const SizedBox(height: TiideSpacing.l),
          LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: TiideColors.midDark,
            color: TiideColors.accent,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => _stop(context, ref, session, elapsed),
            child: const Text('STOP'),
          ),
          const SizedBox(height: TiideSpacing.s),
        ],
      ),
    );
  }

  Future<void> _stop(
    BuildContext context,
    WidgetRef ref,
    Session s,
    Duration elapsed,
  ) async {
    final picked = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const TagPickerSheet(),
    );
    if (picked == null) return;

    final minutes = elapsed.inSeconds <= 0
        ? 1
        : (elapsed.inSeconds / 60).ceil().clamp(1, s.plannedDurationMin);
    await ref.read(sessionRepoProvider).finalize(
          id: s.id,
          actualDurationMin: minutes,
          tagIds: picked,
        );
    if (context.mounted) context.go('/');
  }
}
