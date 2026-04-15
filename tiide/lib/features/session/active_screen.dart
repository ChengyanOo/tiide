import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/session_controller.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../tag/tag_picker_sheet.dart';
import 'breathing_circle.dart';

/// Maximum number of +5-min extensions allowed.
const kMaxExtensions = 3;

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

class _ActiveBody extends ConsumerStatefulWidget {
  const _ActiveBody({required this.session});
  final Session session;

  @override
  ConsumerState<_ActiveBody> createState() => _ActiveBodyState();
}

class _ActiveBodyState extends ConsumerState<_ActiveBody> {
  bool _showTime = false;

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final planned = Duration(minutes: session.plannedDurationMin);
    final elapsed = DateTime.now().difference(session.startedAt);
    final progress = (elapsed.inMilliseconds / planned.inMilliseconds)
        .clamp(0.0, 1.0)
        .toDouble();
    final elapsedMinutes = elapsed.inMilliseconds / 60000.0;
    final canExtend = session.extensionCount < kMaxExtensions;

    return Padding(
      padding: const EdgeInsets.all(TiideSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          // S3.1 + S3.2: Calming breathing circle — long-press reveals time.
          Center(
            child: GestureDetector(
              onLongPressStart: (_) => setState(() => _showTime = true),
              onLongPressEnd: (_) => setState(() => _showTime = false),
              child: _showTime
                  ? _TimeReveal(elapsed: elapsed, planned: planned)
                  : BreathingCircle(
                      progress: progress,
                      elapsedMinutes: elapsedMinutes,
                      plannedMinutes: session.plannedDurationMin,
                    ),
            ),
          ),
          const Spacer(),

          // S3.4: Extend +5 button with cap.
          if (canExtend)
            FilledButton(
              onPressed: () => _extend(context, ref, session),
              child: const Text('+5 MINUTES'),
            )
          else
            Center(
              child: Text(
                'you\'ve got this — max time reached',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: TiideColors.silver),
              ),
            ),
          const SizedBox(height: TiideSpacing.s),
          ElevatedButton(
            onPressed: () => _stop(context, ref, session, elapsed),
            child: const Text('STOP'),
          ),
          const SizedBox(height: TiideSpacing.s),
        ],
      ),
    );
  }

  Future<void> _extend(
      BuildContext context, WidgetRef ref, Session s) async {
    await ref.read(sessionControllerProvider).extend(s.id, minutes: 5);
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
    await ref.read(sessionControllerProvider).finalize(
          id: s.id,
          actualDurationMin: minutes,
          tagIds: picked,
        );
    if (context.mounted) context.go('/');
  }
}

/// Shown on long-press: remaining time in a soft style.
class _TimeReveal extends StatelessWidget {
  const _TimeReveal({required this.elapsed, required this.planned});
  final Duration elapsed;
  final Duration planned;

  @override
  Widget build(BuildContext context) {
    final remaining = planned - elapsed;
    final mins = remaining.inMinutes.clamp(0, 999);
    final secs = (remaining.inSeconds % 60).clamp(0, 59);
    final label = remaining.isNegative
        ? 'done'
        : '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';

    return SizedBox(
      width: 240,
      height: 240,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: TiideColors.silver,
            fontSize: 32,
            fontWeight: FontWeight.w300,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
