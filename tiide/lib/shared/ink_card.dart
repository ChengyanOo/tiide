import 'package:flutter/material.dart';

import '../core/theme.dart';

/// Ink-on-parchment card — `TiideColors.surface` fill, hair2 border, 14px
/// radius. The common surround for grouped content across the app.
class InkCard extends StatelessWidget {
  const InkCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      horizontal: TiideSpacing.m + 2,
      vertical: TiideSpacing.m,
    ),
    this.margin,
    this.clip = Clip.none,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Clip clip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      clipBehavior: clip,
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2),
      ),
      child: child,
    );
  }
}
