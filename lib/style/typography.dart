import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const _lightTextColor = Color(0xFF222222);
  static const _lightSubTextColor = Color(0xFF484848);
  static const _darkTextColor = Colors.white;
  static const _darkSubTextColor = Colors.white70;

  static TextStyle _baseStyle({
    required double size,
    FontWeight weight = FontWeight.w400,
    double letterSpacing = 0,
    required Color color,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: _baseStyle(
      size: 48,
      weight: FontWeight.bold,
      letterSpacing: -1.2,
      color: _lightTextColor,
    ),
    displayMedium: _baseStyle(
      size: 36,
      weight: FontWeight.w700,
      letterSpacing: -0.8,
      color: _lightTextColor,
    ),
    displaySmall: _baseStyle(
      size: 28,
      weight: FontWeight.w600,
      color: _lightTextColor,
    ),
    headlineLarge: _baseStyle(
      size: 24,
      weight: FontWeight.w600,
      color: _lightTextColor,
    ),
    headlineMedium: _baseStyle(
      size: 20,
      weight: FontWeight.w600,
      color: _lightTextColor,
    ),
    titleLarge: _baseStyle(
      size: 18,
      weight: FontWeight.w600,
      color: _lightTextColor,
    ),
    titleMedium: _baseStyle(
      size: 16,
      weight: FontWeight.w500,
      color: _lightSubTextColor,
    ),
    titleSmall: _baseStyle(
      size: 14,
      weight: FontWeight.w500,
      color: _lightSubTextColor,
    ),
    bodyLarge: _baseStyle(
      size: 16,
      weight: FontWeight.w400,
      color: _lightSubTextColor,
    ),
    bodyMedium: _baseStyle(
      size: 14,
      weight: FontWeight.w400,
      color: _lightSubTextColor,
    ),
    bodySmall: _baseStyle(
      size: 12,
      weight: FontWeight.w400,
      color: _lightSubTextColor,
    ),
    labelLarge: _baseStyle(
      size: 14,
      weight: FontWeight.w600,
      letterSpacing: 0.3,
      color: _lightSubTextColor,
    ),
    labelMedium: _baseStyle(
      size: 12,
      weight: FontWeight.w500,
      color: _lightSubTextColor,
    ),
    labelSmall: _baseStyle(
      size: 10,
      weight: FontWeight.w500,
      color: _lightSubTextColor,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: _baseStyle(
      size: 48,
      weight: FontWeight.bold,
      letterSpacing: -1.2,
      color: _darkTextColor,
    ),
    displayMedium: _baseStyle(
      size: 36,
      weight: FontWeight.w700,
      letterSpacing: -0.8,
      color: _darkTextColor,
    ),
    displaySmall: _baseStyle(
      size: 28,
      weight: FontWeight.w600,
      color: _darkTextColor,
    ),
    headlineLarge: _baseStyle(
      size: 24,
      weight: FontWeight.w600,
      color: _darkTextColor,
    ),
    headlineMedium: _baseStyle(
      size: 20,
      weight: FontWeight.w600,
      color: _darkTextColor,
    ),
    titleLarge: _baseStyle(
      size: 18,
      weight: FontWeight.w600,
      color: _darkTextColor,
    ),
    titleMedium: _baseStyle(
      size: 16,
      weight: FontWeight.w500,
      color: _darkSubTextColor,
    ),
    titleSmall: _baseStyle(
      size: 14,
      weight: FontWeight.w500,
      color: _darkSubTextColor,
    ),
    bodyLarge: _baseStyle(
      size: 16,
      weight: FontWeight.w400,
      color: _darkTextColor,
    ),
    bodyMedium: _baseStyle(
      size: 14,
      weight: FontWeight.w400,
      color: _darkSubTextColor,
    ),
    bodySmall: _baseStyle(
      size: 12,
      weight: FontWeight.w400,
      color: _darkSubTextColor,
    ),
    labelLarge: _baseStyle(
      size: 14,
      weight: FontWeight.w600,
      color: _darkTextColor,
    ),
    labelMedium: _baseStyle(
      size: 12,
      weight: FontWeight.w500,
      color: _darkSubTextColor,
    ),
    labelSmall: _baseStyle(
      size: 10,
      weight: FontWeight.w500,
      color: _darkSubTextColor,
    ),
  );
}
