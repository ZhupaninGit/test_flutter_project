import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF7C00FF),
    scaffoldBackgroundColor: Color(0xFF7C00FF),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF7C00FF),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF7C00FF),
      selectedItemColor: const Color(0xFF7C00FF),
      unselectedItemColor: const Color.fromARGB(255, 178, 105, 255),
      showUnselectedLabels: true,
    ),
    cardTheme: CardTheme(
      color: Color(0xFF9E1FFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      margin: EdgeInsets.all(8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(
          Color(0xFF7C00FF),
        ),
        foregroundColor: WidgetStatePropertyAll<Color>(
          Colors.white,
        ),
      ),
    ),
  );
}
