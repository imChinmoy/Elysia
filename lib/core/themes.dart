import 'package:flutter/material.dart';

class AppThemes {
  static const Color primaryBlue = Color(0xFF2F6BFF);
  static const Color secondaryBlueLight = Color(0xFF1E3A8A);
  static const Color lightField = Color(0xFFF1F5FF);
  static const Color background = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF8A8A8A);
  static const Color labelText = Color(0xFF000000);
  static const Color custom = Color(0xFFDDE6FF);
  static const RadialGradient gradient = RadialGradient(
    colors: [Color(0xFFdfe9f3), Color(0xFFffffff)],
    center: Alignment.bottomRight,
    radius: 2.0,
  );
  static const RadialGradient navigationBarColor = RadialGradient(
    colors: [Color(0xFF2F6BFF), Color(0xFFAEDEFC)],
    center: Alignment.topLeft,
    radius: 1.5,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: primaryBlue,
    fontFamily: 'Figtree',

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: primaryBlue),
      titleTextStyle: TextStyle(
        color: primaryBlue,
        fontSize: 28,
        wordSpacing: 10.0,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme : const CardThemeData(
      color: AppThemes.custom,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: primaryBlue,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppThemes.secondaryBlueLight,
      ),
      bodyMedium: TextStyle(fontSize: 13, color: secondaryText),
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightField,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: secondaryText, fontSize: 14),
    ),
  );
}
