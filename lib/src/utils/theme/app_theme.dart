import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Full light + dark ThemeData for Around Us.
///
/// Uses **Outfit** for display/headings and **Inter** for body text.
class AppTheme {
  AppTheme._();

  // ────────────────────────────────────────────────────────────
  //  LIGHT THEME
  // ────────────────────────────────────────────────────────────
  static ThemeData get light {
    const c = AppColors.light;
    return _build(c, Brightness.light);
  }

  // ────────────────────────────────────────────────────────────
  //  DARK THEME
  // ────────────────────────────────────────────────────────────
  static ThemeData get dark {
    const c = AppColors.dark;
    return _build(c, Brightness.dark);
  }

  // ────────────────────────────────────────────────────────────
  //  SHARED BUILDER
  // ────────────────────────────────────────────────────────────
  static ThemeData _build(AppColors c, Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    final bodyFont = GoogleFonts.interTextTheme(base.textTheme);
    final displayFont = GoogleFonts.outfitTextTheme(base.textTheme);

    final textTheme = bodyFont.copyWith(
      displayLarge: displayFont.displayLarge?.copyWith(color: c.textPrimary),
      displayMedium: displayFont.displayMedium?.copyWith(color: c.textPrimary),
      displaySmall: displayFont.displaySmall?.copyWith(color: c.textPrimary),
      headlineLarge: displayFont.headlineLarge?.copyWith(color: c.textPrimary),
      headlineMedium: displayFont.headlineMedium?.copyWith(
        color: c.textPrimary,
      ),
      headlineSmall: displayFont.headlineSmall?.copyWith(color: c.textPrimary),
      titleLarge: displayFont.titleLarge?.copyWith(color: c.textPrimary),
      titleMedium: bodyFont.titleMedium?.copyWith(color: c.textPrimary),
      titleSmall: bodyFont.titleSmall?.copyWith(color: c.textPrimary),
      bodyLarge: bodyFont.bodyLarge?.copyWith(color: c.textPrimary),
      bodyMedium: bodyFont.bodyMedium?.copyWith(color: c.textSecondary),
      bodySmall: bodyFont.bodySmall?.copyWith(color: c.textHint),
      labelLarge: bodyFont.labelLarge?.copyWith(color: c.textPrimary),
      labelMedium: bodyFont.labelMedium?.copyWith(color: c.textSecondary),
      labelSmall: bodyFont.labelSmall?.copyWith(color: c.textHint),
    );

    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.surface,
      cardColor: c.card,
      dividerColor: c.border,
      textTheme: textTheme,

      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.orange,
        onPrimary: Colors.white,
        secondary: AppColors.orange,
        onSecondary: Colors.white,
        surface: c.surface,
        onSurface: c.textPrimary,
        error: const Color(0xFFE53935),
        onError: Colors.white,
      ),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: c.textPrimary,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: c.textPrimary,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surface,
        elevation: 0,
        indicatorColor: AppColors.orangeLight,
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: c.textSecondary,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.inputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.orange, width: 1.5),
        ),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: c.textHint),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
