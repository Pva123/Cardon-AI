import 'package:flutter/material.dart';

class AppTypography {
  static const TextStyle _baseStyle = TextStyle(
    fontSize: 16,
    height: 1.4,
    letterSpacing: 0,
    color: Colors.black,
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

  static TextStyle get bodyTextEmoji => const TextStyle(
        fontFamily: 'NotoColorEmoji',
        fontSize: 16,
        height: 1.4,
        letterSpacing: 0,
        wordSpacing: 0,
        color: Colors.black,
      );
  static TextStyle get navButton => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white, // Adjust as needed for your button text color
      );
}
