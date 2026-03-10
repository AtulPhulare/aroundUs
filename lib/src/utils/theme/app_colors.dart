import 'package:flutter/material.dart';

/// Around Us — Theme-aware Color Palette
///
/// Usage:
///   final colors = AppColors.of(context);
///   Container(color: colors.background)
///
/// For places where context isn't available (rare), use AppColors.light / AppColors.dark.

class AppColors {
  // ── Brand constants (theme-independent) ─────────────
  static const Color orange = Color(0xFFFF5A36);
  static const Color orangeLight = Color(0xFFFFF0ED);

  // Tag colours — identical in both themes
  static const Color tagRed = Color(0xFFFFF0ED);
  static const Color tagBlue = Color(0xFFEDF5FF);
  static const Color tagGreen = Color(0xFFEDFFF4);
  static const Color tagYellow = Color(0xFFFFFBED);
  static const Color tagPurple = Color(0xFFF5EDFF);
  static const Color tagPink = Color(0xFFFFEDF7);

  // ── Themed fields ───────────────────────────────────
  final Color background;
  final Color surface;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color border;
  final Color shadow;
  final Color inputFill;

  const AppColors._({
    required this.background,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.border,
    required this.shadow,
    required this.inputFill,
  });

  // ── Predefined palettes ─────────────────────────────
  static const light = AppColors._(
    background: Color(0xFFFAF9F7),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1A1410),
    textSecondary: Color(0xFF9A8F87),
    textHint: Color(0xFFB0A49C),
    border: Color(0x0D000000),
    shadow: Color(0x0D000000),
    inputFill: Color(0xFFFFFFFF),
  );

  static const dark = AppColors._(
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    card: Color(0xFF252525),
    textPrimary: Color(0xFFF5F5F5),
    textSecondary: Color(0xFF9E9E9E),
    textHint: Color(0xFF757575),
    border: Color(0x1AFFFFFF),
    shadow: Color(0x33000000),
    inputFill: Color(0xFF2A2A2A),
  );

  /// Convenience accessor — picks light/dark based on current brightness.
  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
