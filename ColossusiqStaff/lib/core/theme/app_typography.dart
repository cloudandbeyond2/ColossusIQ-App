import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Unified typography hierarchy for the Professional Education Portal
class AppTypography {
  // Display: 32px / bold
  static TextStyle get displayLarge => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.2,
      );

  // Page title: 24px / 700
  static TextStyle get displayMedium => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
        height: 1.25,
      );

  static TextStyle get pageTitle => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
        height: 1.25,
      );

  // Section title: 18px / 600
  static TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      );

  static TextStyle get sectionTitle => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      );

  // Card title: 16px / 600
  static TextStyle get titleMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleSmall => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Body: 14–15px / regular
  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.45,
      );

  // Small: 12–13px
  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get labelMedium => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  // Caption: 11–12px
  static TextStyle get labelSmall => GoogleFonts.poppins(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: AppColors.textDisabled,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  // Monospace for codes, metrics, timestamps
  static TextStyle get monoLarge => GoogleFonts.jetBrainsMono(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get monoMedium => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
        fontSize: 11.5,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );
}
