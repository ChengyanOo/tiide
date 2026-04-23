import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/session_controller.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../tag/tag_picker_sheet.dart';

/// Orphaned-session retro-edit sheet.
///
/// Matches redesign `DurationSnap` — 5 / 10 / 15 min marks with a horizontal
/// rail, the selected value shown in big serif above.
class RetroEditSheet extends ConsumerStatefulWidget {
  const RetroEditSheet({super.key, required this.session});
  final Session session;

  @override
  ConsumerState<RetroEditSheet> createState() => _RetroEditSheetState();
}

class _RetroEditSheetState extends ConsumerState<RetroEditSheet> {
  static const _marks = [5, 10, 15];
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.session.plannedDurationMin.clamp(5, 15);
  }

  @override
  Widget build(BuildContext context) {
    final startedAt = formatTimeOfDay(widget.session.startedAt);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 22,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: TiideColors.hair,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            const Text(
              'a session was running',
              style: TextStyle(
                fontFamily: tiideSerif,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: TiideColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'started $startedAt · no end was saved.\nhow long did the hardest part last?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: tiideSerif,
                fontSize: 13,
                color: TiideColors.ink3,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            _DurationSnap(
              value: _value,
              marks: _marks,
              onChanged: (v) => setState(() => _value = v),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: TiideColors.ink2,
                      side: const BorderSide(color: TiideColors.hair),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(TiideRadius.card),
                      ),
                    ),
                    child: const Text('discard',
                        style: TextStyle(fontFamily: tiideSerif)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TiideColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final picked = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: TiideColors.surface,
      builder: (_) => const TagPickerSheet(),
    );
    if (!mounted) return;

    await ref.read(sessionControllerProvider).finalize(
          id: widget.session.id,
          actualDurationMin: _value,
          tagIds: picked ?? const [],
          outcome: 'saved',
        );
    if (mounted) Navigator.of(context).pop(true);
  }
}

class _DurationSnap extends StatelessWidget {
  const _DurationSnap({
    required this.value,
    required this.marks,
    required this.onChanged,
  });
  final int value;
  final List<int> marks;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final min = marks.first.toDouble();
    final max = marks.last.toDouble();
    final frac = ((value - min) / (max - min)).clamp(0.0, 1.0);

    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: tiideSerif,
              fontSize: 42,
              fontWeight: FontWeight.w300,
              color: TiideColors.ink,
              height: 1,
            ),
            children: [
              TextSpan(text: '$value'),
              const TextSpan(
                text: ' min',
                style: TextStyle(
                  fontSize: 16,
                  color: TiideColors.ink3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 44,
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth - 12;
              return Stack(
                children: [
                  Positioned(
                    left: 6,
                    right: 6,
                    top: 14,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: TiideColors.hair,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 14,
                    child: Container(
                      width: w * frac,
                      height: 2,
                      decoration: BoxDecoration(
                        color: TiideColors.accent,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                  for (final m in marks)
                    Positioned(
                      left: ((m - min) / (max - min)) * w - 14 + 6,
                      top: 0,
                      child: GestureDetector(
                        onTap: () => onChanged(m),
                        child: SizedBox(
                          width: 28,
                          height: 44,
                          child: Column(
                            children: [
                              const SizedBox(height: 4),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: value == m ? 18 : 10,
                                height: value == m ? 18 : 10,
                                decoration: BoxDecoration(
                                  color: value == m
                                      ? TiideColors.accent
                                      : TiideColors.ink4,
                                  shape: BoxShape.circle,
                                  border: value == m
                                      ? Border.all(
                                          color: TiideColors.bg, width: 3)
                                      : null,
                                  boxShadow: value == m
                                      ? [
                                          BoxShadow(
                                              color: TiideColors.accent
                                                  .withValues(alpha: 0.35),
                                              blurRadius: 0,
                                              spreadRadius: 1),
                                        ]
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('$m',
                                  style: TextStyle(
                                    fontFamily: tiideSerif,
                                    fontSize: 11,
                                    fontWeight: value == m
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    color: value == m
                                        ? TiideColors.accent
                                        : TiideColors.ink4,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
