import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';

class AppFonts {
  const AppFonts._();

  static const String family = 'Inter';

  // Sizes
  static const double xs = 11;
  static const double sm = 13;
  static const double md = 15;
  static const double lg = 17;
  static const double xl = 20;
  static const double xxl = 26;
  static const double xxxl = 32;

  // Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const TextStyle _base = TextStyle(
    fontFamily: family,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get displayLarge =>
      _base.copyWith(fontSize: xxxl, fontWeight: bold, height: 1.2);

  static TextStyle get headingLarge =>
      _base.copyWith(fontSize: xxl, fontWeight: bold, height: 1.25);

  static TextStyle get headingMedium =>
      _base.copyWith(fontSize: xl, fontWeight: semiBold);

  static TextStyle get titleMedium =>
      _base.copyWith(fontSize: lg, fontWeight: semiBold);

  static TextStyle get bodyLarge => _base.copyWith(fontSize: md);

  static TextStyle get bodyMedium => _base.copyWith(fontSize: sm);

  static TextStyle get bodyMuted =>
      _base.copyWith(fontSize: sm, color: AppColors.textSecondary);

  static TextStyle get label =>
      _base.copyWith(fontSize: sm, fontWeight: medium);

  static TextStyle get button => _base.copyWith(
        fontSize: md,
        fontWeight: semiBold,
        color: AppColors.textOnPrimary,
        height: 1,
      );

  static TextStyle get caption =>
      _base.copyWith(fontSize: xs, color: AppColors.textSecondary);

  static TextStyle get error =>
      _base.copyWith(fontSize: sm, color: AppColors.error);
}