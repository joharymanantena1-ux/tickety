import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Surface Philosophy ("The Editorial Ledger")
  static const Color surface = Color(0xFFF9F9F9);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F4);
  static const Color surfaceContainerHigh = Color(0xFFE4E9EA);
  
  // Primary (from gradient references #555f6f to #495363)
  static const Color primary = Color(0xFF555F6F);
  static const Color primaryDim = Color(0xFF495363);
  static const Color onPrimary = Color(0xFFF6F7FF);

  // Secondary
  static const Color secondaryContainer = Color(0xFFE1E2E8);
  static const Color onSecondaryContainer = Color(0xFF4F5257);

  // Ghost Border / Outline
  static const Color outlineVariant = Color(0xFFACB3B4);
  
  // Text
  static const Color onSurface = Color(0xFF2D3435);
}

class AppTheme {
  static ThemeData get lightTheme {
    final textTheme = TextTheme(
      // Display & Headline -> Manrope
      displayLarge: GoogleFonts.manrope(
        fontSize: 56, // 3.5rem
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02,
        color: AppColors.onSurface,
      ),
      headlineLarge: GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
      // Body & Labels -> Inter
      bodyLarge: GoogleFonts.inter(
        fontSize: 16, // 1rem
        fontWeight: FontWeight.w400,
        color: AppColors.onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, // 0.875rem
        fontWeight: FontWeight.w400,
        color: AppColors.onSurface,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.05, // For data tables
        color: AppColors.onSurface,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
        secondaryContainer: AppColors.secondaryContainer,
      ),
      textTheme: textTheme,
      // Ambient shadow defaults
      cardTheme: const CardTheme(
        color: AppColors.surfaceContainerLowest,
        elevation: 0, 
        // Shadow will be layered by container color shifts mostly
        margin: EdgeInsets.all(0),
      ),
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // 0.25rem DEFAULT
          ),
          elevation: 0, // Flat styling per no-line rule
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: outlineGhostBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: outlineGhostBorder),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: outlineGhostBorder),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(4),
        ),
        labelStyle: textTheme.labelLarge,
      ),
    );
  }

  // Ghost border helper (20% opacity of outlineVariant)
  static const Color outlineGhostBorder = Color(0x33ACB3B4);
}
