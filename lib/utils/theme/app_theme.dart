// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.orange, // Replacement for accentColor
      ),
      fontFamily: 'Roboto', // Replace with your preferred font

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            fontSize: 24.0,
            fontStyle: FontStyle.italic), // Replacement for headline6
        bodyLarge: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
      ),

      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Replacement for primary
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
