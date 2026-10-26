import 'package:flutter/material.dart';

/// ACTIFY's cyber command-center design system.
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
  static const Color danger = Color(0xFFFF6B8A);

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: neonCyan,
      onPrimary: background,
      secondary: electricBlue,
      onSecondary: background,
      tertiary: neonViolet,
      surface: surface,
      onSurface: textPrimary,
      error: danger,
      onError: background,
      outline: outline,
    );

    final roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: outline),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: outline,
      splashColor: neonCyan.withValues(alpha: 0.08),
      highlightColor: neonCyan.withValues(alpha: 0.04),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 19,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.8,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
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
        border: roundedBorder,
        enabledBorder: roundedBorder,
        focusedBorder: roundedBorder.copyWith(
          borderSide: const BorderSide(color: neonCyan, width: 1.5),
        ),
      ),
      iconTheme: const IconThemeData(color: neonCyan),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          height: 1.05,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.1,
        ),
        headlineSmall: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(color: textPrimary, height: 1.45),
        bodyMedium: TextStyle(color: textMuted, height: 1.45),
        labelLarge: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.7),
      ),
    );
  }
}
