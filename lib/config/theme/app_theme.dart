import 'package:flutter/material.dart';

class AppTheme {
  // Define the primary color
  static const primaryColor = Color(0xffad4ca0);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Colors
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xFF8E8E93),
      surface: Colors.white,
      onSurface: Colors.black,
      // Adding complementary colors that work well with #acdde0
      tertiary: Color(0xFF7CBEC2),
      // Slightly darker shade for depth
      onPrimary:
      Colors.black87, // Dark text on primary color for better contrast
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryColor.withValues(alpha: 0.1),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 18
      ),

      // default border when not focused
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.transparent, // no border normally
          width: 1.5,
        ),
      ),

      // When user clicks or types in the field
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.black, // highlight color
          width: 2, // slightly thicker
        ),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,//Color(0xffe4bbdf),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18
      )
    )

  );
}