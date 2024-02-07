import 'package:flutter/material.dart';
import 'index.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: scaffoldBackground,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: Colors.white,
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   secondary: accentColor,
    // ),
  );
}
