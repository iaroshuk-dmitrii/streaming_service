import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData dark = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.purple,
      onSecondary: Colors.white,
    ),
  );
}
