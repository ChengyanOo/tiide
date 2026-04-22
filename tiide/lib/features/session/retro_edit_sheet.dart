import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/session_controller.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../tag/tag_picker_sheet.dart';

/// Bottom sheet for retroactively editing an orphaned session.
///
/// Shown when the app opens and an active session exists whose
/// `startedAt + plannedDurationMin + 1 hour` grace window has passed.
class RetroEditSheet extends ConsumerStatefulWidget {
  const RetroEditSheet({super.key, required this.session});
  final Session session;

  @override
  ConsumerState<RetroEditSheet> createState() => _RetroEditSheetState();
}

class _RetroEditSheetState extends ConsumerState<RetroEditSheet> {
  static const _presets = [5, 10, 15];
  late int _selectedMinutes;
  bool _isCustom = false;

  @override
  void initState() {
    super.initState();
    _selectedMinutes = widget.session.plannedDurationMin.clamp(5, 15);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(TiideSpacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'you had a session earlier',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: TiideSpacing.xs),
            Text(
              'how long was the hardest part?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TiideSpacing.l),

            // Preset chips: 5 / 10 / 15.
            Wrap(
              spacing: TiideSpacing.s,
              runSpacing: TiideSpacing.s,
              children: [
                for (final m in _presets)
                  ChoiceChip(
                    label: Text('$m min'),
                    selected: !_isCustom && _selectedMinutes == m,
                    onSelected: (_) => setState(() {
                      _isCustom = false;
                      _selectedMinutes = m;
                    }),
                    backgroundColor: TiideColors.surfaceElev,
                    selectedColor: TiideColors.accent,
                    labelStyle: TextStyle(
                      color: !_isCustom && _selectedMinutes == m
                          ? Colors.black
                          : TiideColors.ink,
                    ),
                    shape: const StadiumBorder(),
                    side: BorderSide.none,
                    showCheckmark: false,
                  ),
                ChoiceChip(
                  label: const Text('custom'),
                  selected: _isCustom,
                  onSelected: (_) => setState(() => _isCustom = true),
                  backgroundColor: TiideColors.surfaceElev,
                  selectedColor: TiideColors.accent,
                  labelStyle: TextStyle(
                    color: _isCustom ? Colors.black : TiideColors.ink,
                  ),
                  shape: const StadiumBorder(),
                  side: BorderSide.none,
                  showCheckmark: false,
                ),
              ],
            ),

            // Custom slider (only when custom is selected).
            if (_isCustom) ...[
              const SizedBox(height: TiideSpacing.m),
              Slider(
                min: 1,
                max: widget.session.plannedDurationMin.toDouble(),
                divisions:
                    (widget.session.plannedDurationMin - 1).clamp(1, 100),
                value: _selectedMinutes
                    .clamp(1, widget.session.plannedDurationMin)
                    .toDouble(),
                activeColor: TiideColors.accent,
                inactiveColor: TiideColors.surfaceElev,
                onChanged: (v) =>
                    setState(() => _selectedMinutes = v.round()),
              ),
            ],

            const SizedBox(height: TiideSpacing.m),
            // Duration preview.
            Center(
              child: Text(
                '$_selectedMinutes min',
                style: const TextStyle(
                  color: TiideColors.accent,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: TiideSpacing.l),
            // Actions.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _save,
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    // Ask for tags.
    final picked = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const TagPickerSheet(),
    );
    if (!mounted) return;

    await ref.read(sessionControllerProvider).finalize(
          id: widget.session.id,
          actualDurationMin: _selectedMinutes,
          tagIds: picked ?? const [],
          outcome: 'saved',
        );
    if (mounted) Navigator.of(context).pop(true);
  }
}
