import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/permissions.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final prefs = ref.read(permissionPrefsProvider);
      if (!prefs.onboardingComplete) {
        context.go('/onboarding');
        return;
      }
      if (!prefs.explainerShown && platformSupportsEnrichment) {
        context.go('/permissions');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final active = ref.watch(activeSessionProvider);

    active.whenData((s) {
      if (s != null && !_retroShown) {
        _maybeShowRetroEdit(context, s);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: active.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (s) {
            final resumable = s != null && !_isOrphaned(s);
            return Column(
              children: [
                const _HomeNav(),
                Expanded(
                  child: resumable
                      ? _ResumeBody(session: s)
                      : _IdleBody(
                          onStart: () async {
                            await ref
                                .read(sessionControllerProvider)
                                .startSession();
                            if (context.mounted) context.push('/active');
                          },
                        ),
                ),
                const _BottomStrip(),
              ],
            );
          },
        ),
      ),
    );
  }

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

class _HomeNav extends StatelessWidget {
  const _HomeNav();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TiideLogo(size: 22),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.insights_outlined,
                    color: TiideColors.ink3, size: 22),
                onPressed: () => context.push('/dashboard'),
              ),
              IconButton(
                icon: const Icon(Icons.view_list_outlined,
                    color: TiideColors.ink3, size: 22),
                onPressed: () => context.push('/sessions'),
              ),
              IconButton(
                icon: const Icon(Icons.tune,
                    color: TiideColors.ink3, size: 22),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IdleBody extends StatelessWidget {
  const _IdleBody({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'make your effort seen.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: tiideSerif,
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: TiideColors.ink3,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 32),
          _SitButton(onPressed: onStart),
          const SizedBox(height: 26),
          const Text(
            'or tap the lockscreen widget,\nback-tap, or quick settings tile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: tiideSerif,
              fontSize: 12,
              color: TiideColors.ink4,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SitButton extends StatelessWidget {
  const _SitButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 240,
        height: 240,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TiideColors.hair, width: 1),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TiideColors.hair, width: 0.5),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment(0, 0.2),
                  radius: 0.85,
                  colors: [TiideColors.accentSoft, Color(0x001C2936)],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'sit',
                  style: TextStyle(
                    fontFamily: tiideSerif,
                    fontStyle: FontStyle.italic,
                    fontSize: 52,
                    fontWeight: FontWeight.w300,
                    color: TiideColors.ink,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '15 MIN',
                  style: TextStyle(
                    fontFamily: tiideSerif,
                    fontSize: 11,
                    letterSpacing: 3.2,
                    color: TiideColors.ink4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumeBody extends StatelessWidget {
  const _ResumeBody({required this.session});
  final Session session;

  @override
  Widget build(BuildContext context) {
    final elapsed = DateTime.now().difference(session.startedAt);
    final mins = elapsed.inMinutes;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'SESSION IN PROGRESS',
            style: TextStyle(
              fontFamily: tiideSerif,
              fontSize: 11,
              letterSpacing: 2.8,
              color: TiideColors.ink4,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: TiideColors.hair, width: 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [TiideColors.accentSoft, Color(0x001C2936)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'started ${mins == 0 ? 'just now' : '$mins min ago'}',
            style: const TextStyle(
              fontFamily: tiideSerif,
              fontStyle: FontStyle.italic,
              color: TiideColors.ink3,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: () => context.push('/active'),
            style: ElevatedButton.styleFrom(
              backgroundColor: TiideColors.accent,
              shape: const StadiumBorder(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 34, vertical: 14),
            ),
            child: const Text('resume',
                style: TextStyle(
                    fontFamily: tiideSerif,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2)),
          ),
        ],
      ),
    );
  }
}

class _BottomStrip extends ConsumerWidget {
  const _BottomStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider).valueOrNull ?? 0;
    final sessions = ref.watch(sessionListProvider).valueOrNull ?? const [];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayCount = sessions.where((r) {
      final d = r.session.startedAt;
      return DateTime(d.year, d.month, d.day) == today &&
          r.session.outcome == 'saved';
    }).length;

    final saved =
        sessions.where((r) => r.session.outcome == 'saved').toList();
    final avgMin = saved.isEmpty
        ? 0
        : (saved
                    .map((r) =>
                        r.session.actualDurationMin ??
                        r.session.plannedDurationMin)
                    .reduce((a, b) => a + b) /
                saved.length)
            .round();

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: TiideColors.hair2, width: 1)),
      ),
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Stat(value: '$streak', label: 'days sat with it'),
          _Stat(value: '$todayCount', label: 'today'),
          _Stat(
              value: saved.isEmpty ? '—' : formatDurationShort(avgMin),
              label: 'avg'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: const TextStyle(
              fontFamily: tiideSerif,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: TiideColors.ink,
              height: 1.1,
            )),
        const SizedBox(height: 2),
        Text(label.toLowerCase(),
            style: const TextStyle(
              fontFamily: tiideSerif,
              fontSize: 11,
              letterSpacing: 0.4,
              color: TiideColors.ink4,
            )),
      ],
    );
  }
}
