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
  static const Color orangeStart = Color(0xFFFF641E);
  static const Color orangeEnd = Color(0xFFFF9A3C);
  static const Color orange = orangeStart;
  static const Color orangeLight = Color(0x66FF641E);

  // Tag colours — identical in both themes
  static const Color tagRed = Color(0x33FF641E);
  static const Color tagBlue = Color(0x332196F3);
  static const Color tagGreen = Color(0x334CAF50);
  static const Color tagYellow = Color(0x33FFC107);
  static const Color tagPurple = Color(0x339C27B0);
  static const Color tagPink = Color(0x33E91E63);

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
    background: Color(0xFF0A0A0A),
    surface: Color(0xFF141414),
    card: Color(0xFF141414),
    textPrimary: Colors.white,
    textSecondary: Color(0x8AFFFFFF),
    textHint: Color(0x61FFFFFF),
    border: Color(0x1AFFFFFF),
    shadow: Color(0x33000000),
    inputFill: Color(0x0AFFFFFF),
  );

  /// Convenience accessor — picks light/dark based on current brightness.
  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
