import 'package:flutter/material.dart';

class AppTypography {
  // Base style without a fixed color, so it inherits from the theme
  static const TextStyle _baseStyle = TextStyle(
    fontSize: 16,
    height: 1.4,
    letterSpacing: 0,
  );

  static TextStyle get header1 => _baseStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  static TextStyle get sectionTitle => _baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  static TextStyle get bodyText => _baseStyle.copyWith(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.2,
      );

  // Emoji style also inherits theme color
  static TextStyle get bodyTextEmoji => _baseStyle.copyWith(
        fontFamily: 'NotoColorEmoji',
        fontSize: 16,
        height: 1.4,
      );

  // Nav button style can remain white if always needed,
  // or we can rely on the theme by removing 'color: Colors.white'
  static TextStyle get navButton => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white, // or remove if you want to inherit theme color
      );
}
