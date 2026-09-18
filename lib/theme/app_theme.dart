import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      
      // Default UI Font
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        titleLarge: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
        bodyMedium: const TextStyle(color: AppColors.textPrimary),
        bodySmall: const TextStyle(color: AppColors.textSecondary),
      ),

      // AppBar Global Styling
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textSecondary),
        titleTextStyle: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 18,
        ),
      ),

      // Card Global Styling (UPDATED to CardThemeData)
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.white12, width: 1),
        ),
      ),

      // Bottom Nav Global Styling
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  // --- Custom Text Styles ---
  static TextStyle get monoStyle => GoogleFonts.jetBrainsMono(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle get tacticalLabel => const TextStyle(
    color: AppColors.textMuted,
    fontSize: 10,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w600,
  );
}