import 'package:flutter/material.dart';
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
      heading: const TextStyle(
        fontFamily: 'Sora',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        height: 1.2,
      ).copyWith(color: c.textPrimary),
      subHeading: const TextStyle(
        fontFamily: 'Sora',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ).copyWith(color: c.textSecondary),
      button: const TextStyle(
        fontFamily: 'Sora',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ).copyWith(color: Colors.white),
      body: const TextStyle(
        fontFamily: 'Sora',
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ).copyWith(color: c.textPrimary),
      hint: const TextStyle(
        fontFamily: 'Sora',
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ).copyWith(color: c.textHint),
    );
  }
}
