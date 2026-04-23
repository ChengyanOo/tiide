import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/tag_colors.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';

class TagPickerSheet extends ConsumerStatefulWidget {
  const TagPickerSheet({super.key});

  @override
  ConsumerState<TagPickerSheet> createState() => _TagPickerSheetState();
}

class _TagPickerSheetState extends ConsumerState<TagPickerSheet> {
  final _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    final tags = ref.watch(tagsProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 22,
          right: 22,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 22,
        ),
        child: tags.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(TiideSpacing.l),
            child: Center(
                child: CircularProgressIndicator(color: TiideColors.accent)),
          ),
          error: (e, _) => Text('$e'),
          data: (list) {
            final byCat = <String, List<Tag>>{};
            for (final t in list) {
              byCat.putIfAbsent(t.category ?? 'other', () => []).add(t);
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: TiideColors.hair,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'tag this one',
                      style: TextStyle(
                        fontFamily: tiideSerif,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: TiideColors.ink,
                      ),
                    ),
                    const Text(
                      'SESSION SAVED',
                      style: TextStyle(
                        fontFamily: tiideSerif,
                        fontSize: 10,
                        letterSpacing: 2.0,
                        color: TiideColors.ink4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final e in byCat.entries) ...[
                          Text(
                            e.key.toLowerCase(),
                            style: const TextStyle(
                              fontFamily: tiideSerif,
                              fontSize: 10,
                              letterSpacing: 1.8,
                              color: TiideColors.ink4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 7,
                            runSpacing: 7,
                            children: [
                              for (final t in e.value)
                                _InkChip(
                                  label: t.label,
                                  selected: _selected.contains(t.id),
                                  color: colorForTag(t.label),
                                  onTap: () => setState(() {
                                    if (_selected.contains(t.id)) {
                                      _selected.remove(t.id);
                                    } else {
                                      _selected.add(t.id);
                                    }
                                  }),
                                ),
                            ],
                          ),
                          const SizedBox(height: 14),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(<String>[]),
                      style: TextButton.styleFrom(
                        foregroundColor: TiideColors.ink3,
                      ),
                      child: const Text('skip',
                          style: TextStyle(
                              fontFamily: tiideSerif, fontSize: 14)),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pop(_selected.toList()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TiideColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(TiideRadius.card),
                        ),
                      ),
                      child: const Text('save',
                          style: TextStyle(
                              fontFamily: tiideSerif,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InkChip extends StatelessWidget {
  const _InkChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dot = color ?? TiideColors.ink4;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? dot.withValues(alpha: 0.14) : TiideColors.surface,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: selected ? dot : TiideColors.hair2,
            width: selected ? 1 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dot,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontFamily: tiideSerif,
                fontSize: 13,
                color: selected ? TiideColors.ink : TiideColors.ink2,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
