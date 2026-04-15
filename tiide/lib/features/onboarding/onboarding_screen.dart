import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/permissions.dart';
import '../../core/theme.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _pageCount = 4;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _finish(context),
                child: const Text('skip',
                    style: TextStyle(color: TiideColors.silver)),
              ),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: const [
                  _PhilosophyPage(),
                  _WidgetSetupPage(),
                  _PermissionsPage(),
                  _FirstSessionPage(),
                ],
              ),
            ),
            // Dots + button
            Padding(
              padding: const EdgeInsets.all(TiideSpacing.l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot indicators
                  Row(
                    children: List.generate(_pageCount, (i) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _page
                              ? TiideColors.accent
                              : TiideColors.borderGray,
                        ),
                      );
                    }),
                  ),
                  // Next / Get Started
                  ElevatedButton(
                    onPressed: () {
                      if (_page < _pageCount - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finish(context);
                      }
                    },
                    child: Text(
                        _page < _pageCount - 1 ? 'NEXT' : 'GET STARTED'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _finish(BuildContext context) async {
    final prefs = ref.read(permissionPrefsProvider);
    await prefs.setOnboardingComplete();
    if (context.mounted) context.go('/');
  }
}

// ---- Page 1: Philosophy ----

class _PhilosophyPage extends StatelessWidget {
  const _PhilosophyPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.waves, color: TiideColors.accent, size: 64),
          const SizedBox(height: TiideSpacing.l),
          Text(
            'ride the wave',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'cravings and distress come in waves.\n'
            'tiide helps you sit with the wave until it passes — '
            'and makes your effort visible.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---- Page 2: Widget Setup ----

class _WidgetSetupPage extends StatelessWidget {
  const _WidgetSetupPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.widgets_outlined, color: TiideColors.accent, size: 64),
          const SizedBox(height: TiideSpacing.l),
          Text(
            'start without opening',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'add the tiide widget to your lock screen or home screen '
            'to start a session with a single tap — no fumbling when '
            'you need it most.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.l),
          Container(
            padding: const EdgeInsets.all(TiideSpacing.m),
            decoration: BoxDecoration(
              color: TiideColors.darkSurface,
              borderRadius: BorderRadius.circular(TiideRadius.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepRow('1', 'Long-press your home screen'),
                const SizedBox(height: TiideSpacing.s),
                _stepRow('2', 'Tap "Widgets" and search for tiide'),
                const SizedBox(height: TiideSpacing.s),
                _stepRow('3', 'Drag the widget to your screen'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepRow(String num, String text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: TiideColors.accent,
          child: Text(num,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: TiideSpacing.s),
        Expanded(
          child: Text(text, style: const TextStyle(color: TiideColors.silver)),
        ),
      ],
    );
  }
}

// ---- Page 3: Permissions ----

class _PermissionsPage extends StatelessWidget {
  const _PermissionsPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shield_outlined, color: TiideColors.accent, size: 64),
          const SizedBox(height: TiideSpacing.l),
          Text(
            'private by default',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'all your data stays on-device and encrypted.\n\n'
            'you can optionally let tiide read heart rate data '
            'and capture coarse location to spot triggers.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'you\'ll choose what to share on the next screen.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: TiideColors.accent),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---- Page 4: First Session ----

class _FirstSessionPage extends StatelessWidget {
  const _FirstSessionPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: TiideColors.accent,
            ),
            child: const Center(
              child: Text('START',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2)),
            ),
          ),
          const SizedBox(height: TiideSpacing.l),
          Text(
            'your first session',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'when a craving hits, tap START.\n\n'
            'a calm breathing circle guides you for 15 minutes. '
            'when the wave passes, tag what triggered it.\n\n'
            'over time, tiide reveals your patterns.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
