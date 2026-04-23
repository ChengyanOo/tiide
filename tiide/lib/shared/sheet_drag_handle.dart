import 'package:flutter/material.dart';

import '../core/theme.dart';

/// 36×4 capsule shown at the top of modal bottom sheets.
class SheetDragHandle extends StatelessWidget {
  const SheetDragHandle({super.key, this.bottomGap = 14});

  final double bottomGap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      margin: EdgeInsets.only(bottom: bottomGap),
      decoration: BoxDecoration(
        color: TiideColors.hair,
        borderRadius: BorderRadius.circular(9999),
      ),
    );
  }
}
