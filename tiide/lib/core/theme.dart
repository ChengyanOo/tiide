import 'package:flutter/material.dart';

class TiideColors {
  // Redesign palette — warm cream / clay
  static const bg = Color(0xFFF5EFE3);
  static const surface = Color(0xFFFBF6EC);
  static const surfaceElev = Color(0xFFEFE7D6);
  static const hair = Color(0xFFDCD2BE);
  static const hair2 = Color(0xFFE8DFCD);

  static const ink = Color(0xFF2A2520);
  static const ink2 = Color(0xFF4A433A);
  static const ink3 = Color(0xFF7A6F5F);
  static const ink4 = Color(0xFFA89B84);

  // Ink accent — monochrome, sumi-like deep blue-black.
  static const accent = Color(0xFF1C2936);
  static const accentSoft = Color(0x221C2936);

  static const negative = Color(0xFFC5534B);
  static const warning = Color(0xFFC8892A);
}

class TiideSpacing {
  static const xs = 4.0;
  static const s = 8.0;
  static const m = 16.0;
  static const l = 24.0;
  static const xl = 32.0;
}

class TiideRadius {
  static const card = 14.0;
  static const pill = 9999.0;
}

const String tiideSerif = 'Georgia';

ThemeData buildTiideTheme() {
  const base = ColorScheme.light(
    surface: TiideColors.bg,
    primary: TiideColors.accent,
    onPrimary: Colors.white,
    secondary: TiideColors.ink3,
    onSurface: TiideColors.ink,
    error: TiideColors.negative,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: base,
    scaffoldBackgroundColor: TiideColors.bg,
    fontFamily: tiideSerif,
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 34,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
        color: TiideColors.ink,
        height: 1.15,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
        color: TiideColors.ink,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: TiideColors.ink,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: TiideColors.ink,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: TiideColors.ink2,
        height: 1.55,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.4,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: TiideColors.ink4,
        letterSpacing: 1.4,
      ),
    ),
    cardTheme: CardThemeData(
      color: TiideColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TiideRadius.card),
        side: const BorderSide(color: TiideColors.hair2, width: 1),
      ),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TiideColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TiideRadius.card),
        ),
        textStyle: const TextStyle(
          fontFamily: tiideSerif,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: TiideColors.surfaceElev,
        foregroundColor: TiideColors.ink,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TiideRadius.card),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: TiideColors.ink3),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: TiideColors.bg,
      foregroundColor: TiideColors.ink,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: tiideSerif,
        fontSize: 17,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w400,
        color: TiideColors.ink,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TiideColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? Colors.white
            : TiideColors.surface,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? TiideColors.accent
            : TiideColors.hair,
      ),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
    dividerColor: TiideColors.hair2,
  );
}

/// Little dot logo used beside the "tiide" wordmark.
class TiideLogo extends StatelessWidget {
  const TiideLogo({super.key, this.size = 28});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'tiide',
          style: TextStyle(
            fontFamily: tiideSerif,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: size,
            color: TiideColors.ink,
            height: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: size * 0.12, bottom: size * 0.1),
          child: Container(
            width: size * 0.18,
            height: size * 0.18,
            decoration: const BoxDecoration(
              color: TiideColors.accent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
