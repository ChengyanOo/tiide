import 'package:flutter/material.dart';

import '../core/theme.dart';

/// Uppercase tracking label sitting atop grouped card content.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: TiideColors.ink4,
            fontSize: 11,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        ?trailing,
      ],
    );
  }
}
