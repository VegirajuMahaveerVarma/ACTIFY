import 'package:flutter/material.dart';

/// ACTIFY's dark cyber-inspired design system.
class ActifyTheme {
  static const Color background = Color(0xFF070A12);
  static const Color surface = Color(0xFF101827);
  static const Color surfaceRaised = Color(0xFF151F31);
  static const Color neonCyan = Color(0xFF35F2E2);
  static const Color electricBlue = Color(0xFF508CFF);
  static const Color neonViolet = Color(0xFF9B7CFF);
  static const Color textPrimary = Color(0xFFEAF2FF);
  static const Color textMuted = Color(0xFF8D9BB4);
  static const Color outline = Color(0xFF26344A);

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: neonCyan,
      brightness: Brightness.dark,
      surface: surface,
    ).copyWith(
      primary: neonCyan,
      secondary: electricBlue,
      tertiary: neonViolet,
      surface: surface,
      onSurface: textPrimary,
      outline: outline,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: outline,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: neonCyan,
          foregroundColor: background,
          minimumSize: const Size(48, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: neonCyan,
          side: const BorderSide(color: outline),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceRaised,
        hintStyle: const TextStyle(color: textMuted),
        labelStyle: const TextStyle(color: textMuted),
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
          borderSide: const BorderSide(color: neonCyan, width: 1.5),
        ),
      ),
      iconTheme: const IconThemeData(color: neonCyan),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 30,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.7,
        ),
        headlineSmall: TextStyle(
          color: textPrimary,
          fontSize: 23,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(color: textPrimary, height: 1.45),
        bodyMedium: TextStyle(color: textMuted, height: 1.45),
        labelLarge: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.6),
      ),
    );
  }
}
