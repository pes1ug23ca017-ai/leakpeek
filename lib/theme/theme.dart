import 'package:flutter/material.dart';

// Color constants
const Color kBackground = Color(0xFFF0F0F0); // Lighter grey
const Color kPrimary = Color(0xFF330066); // Darker purple
const Color kSecondary = Color(0xFF8A2BE2);
const Color kFontColor = Color(0xFF333333); // Dark color for most text

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
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        color: kFontColor,
      ), // Adjust as needed
      displayMedium: TextStyle(fontSize: 45, color: kFontColor),
      displaySmall: TextStyle(fontSize: 36, color: kFontColor),
      headlineLarge: TextStyle(fontSize: 32, color: kFontColor),
      headlineMedium: TextStyle(fontSize: 28, color: kFontColor),
      headlineSmall: TextStyle(fontSize: 24, color: kFontColor),
      titleLarge: TextStyle(fontSize: 22, color: kFontColor),
      titleMedium: TextStyle(
        fontSize: 16,
        color: kFontColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(fontSize: 14, color: kFontColor),
      bodyLarge: TextStyle(fontSize: 16, color: kFontColor),
      bodyMedium: TextStyle(fontSize: 14, color: kFontColor),
      bodySmall: TextStyle(fontSize: 12, color: kFontColor),
      labelLarge: TextStyle(fontSize: 14, color: Colors.white),
      labelMedium: TextStyle(fontSize: 12, color: Colors.white),
      labelSmall: TextStyle(fontSize: 11, color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kPrimary,
        side: const BorderSide(color: kPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: kPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: kSecondary.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimary, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: kSecondary.withOpacity(0.2)),
      ),
    ),
    useMaterial3: true,
  );
}
