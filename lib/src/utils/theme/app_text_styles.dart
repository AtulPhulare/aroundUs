import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Theme-aware text styles via `AppTextStyles.of(context)`.
class AppTextStyles {
  final TextStyle heading;
  final TextStyle subHeading;
  final TextStyle button;
  final TextStyle body;
  final TextStyle hint;

  const AppTextStyles._({
    required this.heading,
    required this.subHeading,
    required this.button,
    required this.body,
    required this.hint,
  });

  static AppTextStyles of(BuildContext context) {
    final c = AppColors.of(context);
    return AppTextStyles._(
      heading: GoogleFonts.outfit(
        fontSize: 38,
        fontWeight: FontWeight.w900,
        color: c.textPrimary,
        letterSpacing: -1.5,
        height: 1.1,
      ),
      subHeading: GoogleFonts.inter(
        fontSize: 14.5,
        color: c.textSecondary,
        height: 1.5,
      ),
      button: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: Colors.white,
      ),
      body: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: c.textPrimary,
      ),
      hint: GoogleFonts.inter(fontSize: 14, color: c.textHint),
    );
  }
}
