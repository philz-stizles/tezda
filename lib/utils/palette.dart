import 'package:flutter/material.dart';

class Palette {
  static const primary = Color(0xFF5072f6);
  static const red = Color(0xFFEB1C24);
  static const grey = Color(0xFF5A5A5A);
  static const midGrey = Color(0xFFD1D1D1);
  static const lightGrey = Color(0xFFF3F3F3);
  static const lighterGrey = Color(0xFFE5E5E5);
  static const secondary = Color(0xFF1B1C1E);
  static const white = Color(0xFFFFFFFF);
  static const label = Color(0xFF1B1C1E);
  static const dimWhite = Color(0xFFF9F9F9);
  static const ash = Color(0xFFB9B9B9);
  static const success = Color(0xFF65D88C);

  static MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
