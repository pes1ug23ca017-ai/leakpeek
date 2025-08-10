import 'package:flutter/material.dart';

// Color constants
const Color kBackground = Color(0xFFF5F5F5);
const Color kPrimary = Color(0xFF5A189A);
const Color kSecondary = Color(0xFF8A2BE2);

ThemeData buildLeakPeekTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: kPrimary,
    primary: kPrimary,
    secondary: kSecondary,
    surface: Colors.white,
    brightness: Brightness.light,
  );

  return ThemeData(
    colorScheme: scheme,
    // 'background' is deprecated in Material 3; prefer surface and use
    // scaffoldBackgroundColor directly.
    scaffoldBackgroundColor: kBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: kPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: kSecondary.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimary, width: 2),
      ),
    ),
    useMaterial3: true,
  );
}


