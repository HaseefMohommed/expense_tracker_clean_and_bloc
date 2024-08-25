import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // static values
  // *****************
  static const double primaryPadding = 24;
  static const double primaryButtonHeight = 48;
  static const double primaryButtonFontSize = 16;

  // *****************
  // static colors
  // *****************

  static const Color primaryColor = Color(0xFF1D41F9);
  static const Color secondaryColor = Color(0xFFF5F6F7);
  static const Color buttonBorderColor = Color(0xFFDCDFE3);
  static const Color successColor = Color(0xFF5C9F5C);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFDD9226);
  static const Color infoColor = Color(0xFF326A6B);
  static const Color textColor = Colors.black;
  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Colors.black;
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.black;

  static const Color _iconColor = Colors.black;

  // *****************
  // Text Style - light
  // *****************
  static const TextStyle _lightHeadingText = TextStyle(
      color: _lightTextColorPrimary, fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText = TextStyle(
      color: _lightTextColorPrimary,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 16);

  static const TextTheme _lightTextTheme = TextTheme(
    displayMedium: _lightHeadingText,
    displaySmall: _lightBodyText,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: _iconColor), elevation: 0.3),
    bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      primaryContainer: _lightPrimaryVariantColor,
    ),
    textTheme: _lightTextTheme,
  );
}
