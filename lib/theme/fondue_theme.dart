import 'package:flutter/material.dart';

class FondueTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0066FF),
        primary: const Color(0xFF0066FF),
        secondary: const Color(0xFF00B8D9),
        tertiary: const Color(0xFF36B37E),
        error: const Color(0xFFFF5630),
        background: const Color(0xFFF4F5F7),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF172B4D),
        elevation: 0,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF172B4D),
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF172B4D),
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF172B4D),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF172B4D),
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF172B4D)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF172B4D)),
      ),
    );
  }
}
