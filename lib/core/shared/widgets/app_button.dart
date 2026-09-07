import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

enum AppButtonVariant { filled, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expanded;
  final IconData? icon;
  final AppButtonVariant variant;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.expanded = true,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.height = 54,
  });

  bool get _disabled => isLoading || onPressed == null;

  Color get _fg => variant == AppButtonVariant.filled
      ? AppColors.textOnPrimary
      : AppColors.primary;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2.2, color: _fg),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: _fg),
                const SizedBox(width: 8),
              ],
              Text(label, style: AppFonts.button.copyWith(color: _fg)),
            ],
          );

    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));

    Widget button;
    switch (variant) {
      case AppButtonVariant.filled:
        button = ElevatedButton(
          onPressed: _disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.disabled,
            elevation: 0,
            shape: shape,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: _disabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary, width: 1.4),
            shape: shape,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: _disabled ? null : onPressed,
          style: TextButton.styleFrom(shape: shape),
          child: child,
        );
        break;
    }

    return SizedBox(
      width: expanded ? double.infinity : null,
      height: height,
      child: button,
    );
  }
}