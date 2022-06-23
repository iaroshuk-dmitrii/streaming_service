import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData dark = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.purple,
      onSecondary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(toolbarHeight: 60),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.purple,
      inactiveTrackColor: Colors.grey,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
      ),
      labelLarge: TextStyle(
        fontSize: 15,
      ),
      labelMedium: TextStyle(
        color: Colors.grey,
        fontSize: 10,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  );
}
