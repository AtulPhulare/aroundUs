import 'package:flutter/material.dart';
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

    final textTheme = base.textTheme.apply(
      fontFamily: 'Sora',
      displayColor: c.textPrimary,
      bodyColor: c.textPrimary,
    ).copyWith(
      bodyMedium: base.textTheme.bodyMedium?.copyWith(
        color: c.textSecondary,
        fontFamily: 'Sora',
      ),
      bodySmall: base.textTheme.bodySmall?.copyWith(
        color: c.textHint,
        fontFamily: 'Sora',
      ),
      labelMedium: base.textTheme.labelMedium?.copyWith(
        color: c.textSecondary,
        fontFamily: 'Sora',
      ),
      labelSmall: base.textTheme.labelSmall?.copyWith(
        color: c.textHint,
        fontFamily: 'Sora',
      ),
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
        titleTextStyle: const TextStyle(
          fontFamily: 'Sora',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ).copyWith(color: c.textPrimary),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surface,
        elevation: 0,
        indicatorColor: AppColors.orangeLight,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: 'Sora',
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
          textStyle: const TextStyle(
            fontFamily: 'Sora',
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
        hintStyle: TextStyle(
          fontFamily: 'Sora',
          fontSize: 14,
          color: c.textHint,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        labelStyle: TextStyle(
          fontFamily: 'Sora',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
