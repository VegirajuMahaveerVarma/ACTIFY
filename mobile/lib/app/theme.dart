import 'package:flutter/material.dart';

class ActifyTheme {
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF080A0E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFFCD28),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
