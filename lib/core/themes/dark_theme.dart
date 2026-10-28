import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF181818),
  primaryColor: Color(0xFFA0A0A0),
  primaryColorLight: Color(0xFFFFFCFC),
  primaryColorDark: Color(0xFFC6C6C6),
  cardColor: Color(0xFF282828),
  secondaryHeaderColor: Color(0xFFFFFCFC),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xFF181818),
    foregroundColor: Color(0xFFF6F7F9),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFF181818),
    selectedItemColor: Color(0xFF15B86C),
    unselectedItemColor: Color(0xFFFFFCFC),
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
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: Color(0xFF282828),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Color(0xFFC6C6C6),
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w500,
    ),
  ),
);
