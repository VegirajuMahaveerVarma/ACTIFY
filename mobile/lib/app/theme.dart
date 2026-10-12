import 'package:flutter/material.dart';

/// Shared ACTIFY visual system: dark surfaces with a restrained cyber-green signal.
class ActifyTheme {
  static const Color background = Color(0xFF080B0D);
  static const Color surface = Color(0xFF101619);
  static const Color elevatedSurface = Color(0xFF151E21);
  static const Color neon = Color(0xFFB8FF5C);
  static const Color muted = Color(0xFF93A39D);
  static const Color outline = Color(0xFF263638);

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: neon,
      brightness: Brightness.dark,
      surface: surface,
    ).copyWith(
      primary: neon,
      onPrimary: const Color(0xFF101609),
      secondary: const Color(0xFF5DE2C2),
      onSecondary: const Color(0xFF061410),
      surface: surface,
      onSurface: const Color(0xFFE8F0EB),
      outline: outline,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Color(0xFFE8F0EB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFFE8F0EB),
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: outline, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: neon,
          foregroundColor: const Color(0xFF101609),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: neon,
          side: const BorderSide(color: outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: elevatedSurface,
        hintStyle: const TextStyle(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: neon, width: 1.4),
        ),
      ),
      dividerTheme: const DividerThemeData(color: outline, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: elevatedSurface,
        contentTextStyle: const TextStyle(color: Color(0xFFE8F0EB)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
