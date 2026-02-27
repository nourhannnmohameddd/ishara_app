import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Light theme only. Uses [AppColors], [AppTextStyles], [AppSpacing].
/// Border radius: 12. Dark theme not implemented yet.
abstract class AppTheme {
  AppTheme._();

  static const double _borderRadius = 12.0;

  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.background,
      onSurface: AppColors.text,
    );

    final textTheme = TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.text),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.text),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.text),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.text),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.text),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.text),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.text),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.text),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.text),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.text),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.text),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.text),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.text),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.text),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.text),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.small,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.small,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.small,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: AppColors.inactiveDot),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.text),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.inactiveDot),
      ),
    );
  }
}
