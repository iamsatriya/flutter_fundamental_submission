import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_fundamental_submission/style/typography.dart';

// Brand colors
const appRed = Color(0xFFE5484D);
const appTeal = Color(0xFF00A699);
const appDarkGrey = Color(0xFF484848);
const appLightGrey = Color(0xFFF7F7F7);

/// LIGHT THEME
ThemeData appLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: appLightGrey,

  dividerColor: Colors.black12,

  tabBarTheme: TabBarThemeData(
    labelColor: appRed,
    unselectedLabelColor: appDarkGrey.withValues(alpha: 0.6),
    labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
    unselectedLabelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: appRed, width: 2),
    ),
    indicatorSize: TabBarIndicatorSize.label,
    dividerColor: Colors.transparent,
  ),

  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: appRed,
    onPrimary: Colors.white,
    secondary: appTeal,
    onSecondary: Colors.white,
    error: Color(0xFFFF385C),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: appDarkGrey,
    surfaceContainerHighest: appLightGrey,
    tertiary: Colors.black,
    onTertiary: Colors.white,
  ),

  textTheme: AppTypography.lightTextTheme,

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: appDarkGrey,
    elevation: 0,
    titleTextStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: appDarkGrey,
    ),
    iconTheme: const IconThemeData(color: appDarkGrey),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appRed,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: appDarkGrey,
      side: const BorderSide(color: Color(0xFFDDDDDD)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: appRed, width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0xFFB0B0B0)),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 8,
    selectedItemColor: appRed,
    unselectedItemColor: appDarkGrey.withValues(alpha: 0.6),
    selectedLabelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    unselectedLabelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ).copyWith(inherit: false),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
  ),
);

/// DARK THEME
ThemeData appDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),

  dividerColor: Colors.white12,

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: appRed,
    onPrimary: Colors.white,
    secondary: appTeal,
    onSecondary: Colors.white,
    error: Color(0xFFFF385C),
    onError: Colors.white,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF121212),
    tertiary: Colors.white,
    onTertiary: Colors.black,
  ),

  textTheme: AppTypography.darkTextTheme,

  tabBarTheme: TabBarThemeData(
    labelColor: appRed,
    unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
    labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
    unselectedLabelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: appRed, width: 2),
    ),
    indicatorSize: TabBarIndicatorSize.label,
    dividerColor: Colors.transparent,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appRed,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFF555555)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF444444)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: appRed, width: 1.5),
    ),
    hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF1E1E1E),
    elevation: 8,
    selectedItemColor: appRed,
    unselectedItemColor: Colors.white.withValues(alpha: 0.7),
    selectedLabelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    unselectedLabelStyle: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ).copyWith(inherit: false),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
  ),
);
