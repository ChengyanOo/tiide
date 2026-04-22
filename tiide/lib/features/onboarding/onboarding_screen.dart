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
  static const _pageCount = 3;

  final Set<String> _selectedCats = {'Psalms', 'Gospels', 'Letters'};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _PhilosophyPage(),
      const _EntryPointsPage(),
      _VersesPage(
        selected: _selectedCats,
        onToggle: (c) => setState(() {
          if (_selectedCats.contains(c)) {
            _selectedCats.remove(c);
          } else {
            _selectedCats.add(c);
          }
        }),
      ),
    ];

    final ctas = ['begin', 'next', 'next'];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            _Dots(page: _page, count: _pageCount),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  TiideSpacing.l, TiideSpacing.s, TiideSpacing.l, TiideSpacing.l),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_page < _pageCount - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeOut,
                      );
                    } else {
                      _finish(context);
                    }
                  },
                  child: Text(ctas[_page]),
                ),
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
    if (!context.mounted) return;
    if (platformSupportsEnrichment && !prefs.explainerShown) {
      context.go('/permissions');
    } else {
      context.go('/');
    }
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.page, required this.count});
  final int page;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == page;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20 : 5,
          height: 5,
          decoration: BoxDecoration(
            color: active ? TiideColors.accent : TiideColors.hair,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

// ---- Page 1: Philosophy ----

class _PhilosophyPage extends StatelessWidget {
  const _PhilosophyPage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TiideLogo(size: 34),
          const SizedBox(height: 36),
          Text(
            'make your effort seen.',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'tiide is a passive timer for the moments\nyou choose not to act. it keeps a quiet\nrecord, so you can notice what passes.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---- Page 2: Entry points ----

class _EntryPointsPage extends StatelessWidget {
  const _EntryPointsPage();
  @override
  Widget build(BuildContext context) {
    const items = [
      ('lockscreen widget', 'hold lockscreen → add widget'),
      ('back-tap', 'settings → touch → back-tap'),
      ('quick-settings tile', 'edit tiles → add tiide'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TiideLogo(size: 34),
          const SizedBox(height: 28),
          Text(
            'start in one tap.',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'most sessions begin outside the app —\nfrom your lockscreen widget, a back-tap,\nor a quick-settings tile.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.xl),
          ...items.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _EntryRow(name: e.$1, sub: e.$2),
              )),
        ],
      ),
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.name, required this.sub});
  final String name;
  final String sub;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: TiideColors.accentSoft,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Center(
              child: SizedBox(
                width: 10,
                height: 10,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: TiideColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: TiideColors.ink, fontSize: 15)),
                Text(sub,
                    style: const TextStyle(
                      color: TiideColors.ink4,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: TiideColors.ink4, size: 16),
        ],
      ),
    );
  }
}

// ---- Page 3: Verse picker ----

const _verseCats = [
  'Psalms',
  'Gospels',
  'Letters',
  'Wisdom',
  'Prophets',
];

class _VersesPage extends StatelessWidget {
  const _VersesPage({required this.selected, required this.onToggle});
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TiideSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TiideLogo(size: 34),
          const SizedBox(height: 28),
          Text(
            'pick what keeps\nyou company.',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.m),
          Text(
            'during a session, a short verse fades in.\nyou can always change this later.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TiideSpacing.xl),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _verseCats
                .map((c) => _Chip(
                      label: c,
                      selected: selected.contains(c),
                      onTap: () => onToggle(c),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(
      {required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(99),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? TiideColors.accent : Colors.transparent,
          border: Border.all(
            color: selected ? TiideColors.accent : TiideColors.hair,
          ),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : TiideColors.ink2,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
