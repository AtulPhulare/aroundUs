import 'package:flutter/material.dart';

/// Around Us — App Color Palette
/// Usage: import 'app_colors.dart'; then use AppColors.orange, etc.

abstract class AppColors {
  // ── Primary ──────────────────────────────────
  /// Coral orange — primary brand color, CTAs, accents
  static const Color orange = Color(0xFFFF5A36);

  /// Light orange tint — backgrounds, badges, icon containers
  static const Color orangeLight = Color(0xFFFFF0ED);

  // ── Neutrals ─────────────────────────────────
  /// Near-black — headings, primary text
  static const Color dark = Color(0xFF1A1410);

  /// Warm grey — body text, subtitles
  static const Color muted = Color(0xFF9A8F87);

  /// Lighter warm grey — placeholders, hints, captions
  static const Color hint = Color(0xFFB0A49C);

  // ── Backgrounds ──────────────────────────────
  /// Off-white — main scaffold background
  static const Color background = Color(0xFFFAF9F7);

  /// Pure white — cards, input fields, modals
  static const Color surface = Color(0xFFFFFFFF);

  // ── Tag / Chip backgrounds ────────────────────
  static const Color tagRed = Color(0xFFFFF0ED);
  static const Color tagBlue = Color(0xFFEDF5FF);
  static const Color tagGreen = Color(0xFFEDFFF4);
  static const Color tagYellow = Color(0xFFFFFBED);
  static const Color tagPurple = Color(0xFFF5EDFF);
  static const Color tagPink = Color(0xFFFFEDF7);

  // ── Utility ───────────────────────────────────
  /// Dividers, subtle borders
  static const Color border = Color(0x0D000000); // black 5%

  /// Shadow base color
  static const Color shadow = Color(0x0D000000); // black 5%
}
