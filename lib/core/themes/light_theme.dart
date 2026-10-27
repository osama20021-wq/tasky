import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  primaryColorLight: Color(0xFF161F1B),
  primaryColor: Color(0xFF6A6A6A),
  secondaryHeaderColor: Color(0xFF181818),
  primaryColorDark: Color(0xFF3A4640),
  cardColor: Color(0xFFFFFFFF),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xFFF6F7F9),
    foregroundColor: Color(0xFF181818),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: Color(0xFFFFFCFC),
      backgroundColor: Color(0xFF15B86C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationThemeData(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Color(0xFF3A4640),
      fontWeight: FontWeight.w400,
    ),
  ),
);
