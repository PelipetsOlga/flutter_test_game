import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors from splash.svg
  static const Color primaryBlue = Color(0xFF002B5A); // Main background blue
  static const Color secondaryBlue = Color(0xFF1D60AA); // Secondary blue
  static const Color accentOrange = Color(0xFFFA4D01); // Orange accent
  static const Color warmOrange = Color(0xFFFE8D3B); // Warm orange
  static const Color brightOrange = Color(0xFFF01515); // Bright orange
  static const Color yellowAccent = Color(0xFFFFE111); // Yellow accent

  // Neutral colors
  static const Color white = Colors.white;
  static const Color darkBlue = Color(0xFF002956);
  static const Color lightBlue = Color(0xFF003B7C);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentOrange,
        background: primaryBlue,
        surface: secondaryBlue,
        onPrimary: white,
        onSecondary: white,
        onBackground: white,
        onSurface: white,
      ),
      scaffoldBackgroundColor: primaryBlue,
      useMaterial3: true,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Floating Action Button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentOrange,
        foregroundColor: white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: white, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: white, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: white, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: white, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: white, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: white, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: white, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(color: white, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: white, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: white),
        bodyMedium: TextStyle(color: white),
        bodySmall: TextStyle(color: white),
        labelLarge: TextStyle(color: white, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: white, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(color: white, fontWeight: FontWeight.w500),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: secondaryBlue.withOpacity(0.8),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentOrange,
          foregroundColor: white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryBlue.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentOrange, width: 2),
        ),
        labelStyle: TextStyle(color: white.withOpacity(0.8)),
        hintStyle: TextStyle(color: white.withOpacity(0.6)),
      ),
    );
  }
}
