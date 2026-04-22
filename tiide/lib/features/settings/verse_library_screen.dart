import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme.dart';

class VerseLibraryScreen extends StatefulWidget {
  const VerseLibraryScreen({super.key});

  @override
  State<VerseLibraryScreen> createState() => _VerseLibraryScreenState();
}

class _VerseLibraryScreenState extends State<VerseLibraryScreen> {
  String _tab = 'browse';
  String _cadence = 'default';
  final Set<String> _enabled = {'Psalms', 'Gospels', 'Wisdom'};

  static const _cats = [
    ('Psalms', 42),
    ('Gospels', 28),
    ('Letters', 14),
    ('Wisdom', 19),
    ('Prophets', 9),
    ('User-written', 3),
  ];

  static const _verses = [
    ('Be still, and know\nthat I am God.', 'Psalm 46:10', 'Psalms'),
    ('My grace is sufficient for you.', '2 Corinthians 12:9', 'Letters'),
    ('Come to me, all you who are weary.', 'Matthew 11:28', 'Gospels'),
    ('The Lord is my shepherd,\nI lack nothing.', 'Psalm 23:1', 'Psalms'),
    ('Cast all your anxiety on him\nbecause he cares for you.', '1 Peter 5:7',
        'Letters'),
    ('A gentle answer turns away wrath.', 'Proverbs 15:1', 'Wisdom'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('verse library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 20, color: TiideColors.ink3),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _Tabs(
            tab: _tab,
            onTab: (t) => setState(() => _tab = t),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              children: [
                _PreviewCard(),
                const SizedBox(height: 18),
                const _Label('CATEGORIES'),
                const SizedBox(height: 10),
                _CategoriesCard(
                  cats: _cats,
                  enabled: _enabled,
                  onToggle: (c) => setState(() {
                    if (_enabled.contains(c)) {
                      _enabled.remove(c);
                    } else {
                      _enabled.add(c);
                    }
                  }),
                ),
                const SizedBox(height: 18),
                const _Label('CADENCE DURING SESSION'),
                const SizedBox(height: 10),
                _CadenceCard(
                  value: _cadence,
                  onChanged: (v) => setState(() => _cadence = v),
                ),
                const SizedBox(height: 18),
                const _Label('BROWSE'),
                const SizedBox(height: 6),
                for (int i = 0; i < _verses.length; i++)
                  _VerseRow(
                    text: _verses[i].$1,
                    attr: _verses[i].$2,
                    cat: _verses[i].$3,
                    saved: i < 3,
                    last: i == _verses.length - 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.tab, required this.onTab});
  final String tab;
  final ValueChanged<String> onTab;
  @override
  Widget build(BuildContext context) {
    const opts = ['browse', 'saved', 'custom'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 4, 22, 8),
      child: Row(
        children: [
          for (final o in opts)
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: InkWell(
                onTap: () => onTab(o),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: tab == o
                            ? TiideColors.accent
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    o,
                    style: TextStyle(
                      color: tab == o ? TiideColors.ink : TiideColors.ink4,
                      fontStyle:
                          tab == o ? FontStyle.italic : FontStyle.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: TiideColors.ink4,
        fontSize: 11,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8C6A4E), Color(0xFF4A342A)],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned(
            top: 12,
            left: 14,
            child: Text(
              'PREVIEW',
              style: TextStyle(
                color: Color(0xAAF3EFE6),
                fontSize: 11,
                letterSpacing: 1.4,
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Be still, and know\nthat I am God.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF3EFE6),
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      height: 1.35,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '— Psalm 46:10',
                    style: TextStyle(
                      color: Color(0x99F3EFE6),
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesCard extends StatelessWidget {
  const _CategoriesCard({
    required this.cats,
    required this.enabled,
    required this.onToggle,
  });
  final List<(String, int)> cats;
  final Set<String> enabled;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (int i = 0; i < cats.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: i < cats.length - 1
                    ? const Border(
                        bottom: BorderSide(color: TiideColors.hair2),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(cats[i].$1,
                        style: const TextStyle(
                          color: TiideColors.ink,
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('${cats[i].$2}',
                        style: const TextStyle(
                          color: TiideColors.ink4,
                          fontSize: 13,
                        )),
                  ),
                  Transform.scale(
                    scale: 0.85,
                    child: Switch(
                      value: enabled.contains(cats[i].$1),
                      onChanged: (_) => onToggle(cats[i].$1),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CadenceCard extends StatelessWidget {
  const _CadenceCard({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    const opts = [
      ('off', 'off', null),
      ('slow', 'slow', 'one verse, held'),
      ('default', 'default', 'new every 2 min'),
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2),
      ),
      child: Row(
        children: [
          for (final o in opts)
            Expanded(
              child: InkWell(
                onTap: () => onChanged(o.$1),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                  decoration: BoxDecoration(
                    color: value == o.$1
                        ? TiideColors.surfaceElev
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(o.$2,
                          style: TextStyle(
                            color: value == o.$1
                                ? TiideColors.ink
                                : TiideColors.ink3,
                            fontStyle: value == o.$1
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontSize: 14,
                          )),
                      if (o.$3 != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(o.$3!,
                              style: const TextStyle(
                                color: TiideColors.ink4,
                                fontSize: 11,
                              )),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _VerseRow extends StatelessWidget {
  const _VerseRow({
    required this.text,
    required this.attr,
    required this.cat,
    required this.saved,
    required this.last,
  });
  final String text;
  final String attr;
  final String cat;
  final bool saved;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(
                bottom: BorderSide(color: TiideColors.hair2),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style: const TextStyle(
                color: TiideColors.ink,
                fontStyle: FontStyle.italic,
                fontSize: 16,
                height: 1.4,
              )),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text('— $attr · $cat',
                    style: const TextStyle(
                      color: TiideColors.ink4,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    )),
              ),
              Icon(
                saved ? Icons.bookmark : Icons.bookmark_border,
                size: 14,
                color: saved ? TiideColors.accent : TiideColors.ink4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
