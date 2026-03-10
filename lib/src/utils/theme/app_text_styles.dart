import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w900,
    color: AppColors.dark,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static const subHeading = TextStyle(
    fontSize: 14.5,
    color: AppColors.muted,
    height: 1.5,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  static const body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  static const hint = TextStyle(fontSize: 14, color: AppColors.hint);
}
