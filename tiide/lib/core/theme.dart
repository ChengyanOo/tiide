import 'package:flutter/material.dart';

class TiideColors {
  static const nearBlack = Color(0xFF121212);
  static const darkSurface = Color(0xFF181818);
  static const midDark = Color(0xFF1F1F1F);
  static const darkCard = Color(0xFF252525);
  static const borderGray = Color(0xFF4D4D4D);
  static const lightBorder = Color(0xFF7C7C7C);
  static const silver = Color(0xFFB3B3B3);
  static const nearWhite = Color(0xFFCBCBCB);
  static const white = Color(0xFFFFFFFF);
  static const accent = Color(0xFF1ED760);
  static const accentBorder = Color(0xFF1DB954);
  static const negative = Color(0xFFF3727F);
  static const warning = Color(0xFFFFA42B);
}

class TiideSpacing {
  static const xs = 4.0;
  static const s = 8.0;
  static const m = 16.0;
  static const l = 24.0;
  static const xl = 32.0;
}

class TiideRadius {
  static const card = 8.0;
  static const pill = 9999.0;
  static const largePill = 500.0;
}

ThemeData buildTiideTheme() {
  const base = ColorScheme.dark(
    surface: TiideColors.nearBlack,
    primary: TiideColors.accent,
    onPrimary: Colors.black,
    secondary: TiideColors.silver,
    onSurface: TiideColors.white,
    error: TiideColors.negative,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: base,
    scaffoldBackgroundColor: TiideColors.nearBlack,
    fontFamily: 'Helvetica Neue',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: TiideColors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: TiideColors.white,
        height: 1.3,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: TiideColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: TiideColors.silver,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: TiideColors.white,
        letterSpacing: 1.4,
      ),
    ),
    cardTheme: CardThemeData(
      color: TiideColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TiideRadius.card),
      ),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TiideColors.accent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: TiideColors.midDark,
        foregroundColor: TiideColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: const StadiumBorder(),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: TiideColors.nearBlack,
      foregroundColor: TiideColors.white,
      elevation: 0,
      centerTitle: false,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TiideColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    dividerColor: TiideColors.borderGray,
  );
}
