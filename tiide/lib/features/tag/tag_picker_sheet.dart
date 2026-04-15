import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';

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
        padding: const EdgeInsets.all(TiideSpacing.l),
        child: tags.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(TiideSpacing.l),
            child: Center(
                child: CircularProgressIndicator(color: TiideColors.accent)),
          ),
          error: (e, _) => Text('$e'),
          data: (list) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('tag this session',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: TiideSpacing.m),
              Wrap(
                spacing: TiideSpacing.s,
                runSpacing: TiideSpacing.s,
                children: [
                  for (final t in list)
                    FilterChip(
                      label: Text(t.label),
                      selected: _selected.contains(t.id),
                      onSelected: (v) => setState(() {
                        v ? _selected.add(t.id) : _selected.remove(t.id);
                      }),
                      backgroundColor: TiideColors.midDark,
                      selectedColor: TiideColors.accent,
                      labelStyle: TextStyle(
                          color: _selected.contains(t.id)
                              ? Colors.black
                              : TiideColors.white),
                      shape: const StadiumBorder(),
                      side: BorderSide.none,
                      showCheckmark: false,
                    ),
                ],
              ),
              const SizedBox(height: TiideSpacing.l),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(<String>[]),
                    child: const Text('skip',
                        style: TextStyle(color: TiideColors.silver)),
                  ),
                  const SizedBox(width: TiideSpacing.s),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(_selected.toList()),
                    child: const Text('SAVE'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
