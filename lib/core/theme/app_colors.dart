import 'package:flutter/material.dart';

/// Centralized app colors. Used by [AppTheme] and shared widgets.
abstract class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0B2B5B);
  static const Color background = Color(0xFFC9D6F2);
  static const Color text = Color(0xFF1A1A1A);
  static const Color inactiveDot = Color(0xFFCCCCCC);

  /// For text and icons on primary-colored surfaces.
  static const Color onPrimary = Color(0xFFFFFFFF);
}
