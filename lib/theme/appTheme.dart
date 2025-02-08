import 'package:flutter/material.dart';

class Apptheme {
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  static ThemeData get lightTeme {
    return ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.white)),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: accentColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))),
        cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ));
  }
}
