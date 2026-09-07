import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

enum AppMessageType { error, success, warning, info }

class AppMessageBanner extends StatelessWidget {
  final String message;
  final AppMessageType type;
  final VoidCallback? onDismiss;

  const AppMessageBanner({
    super.key,
    required this.message,
    this.type = AppMessageType.error,
    this.onDismiss,
  });

  (Color, Color, IconData) get _style => switch (type) {
        AppMessageType.error =>
          (AppColors.errorSurface, AppColors.error, Icons.error_outline),
        AppMessageType.success => (
            AppColors.successSurface,
            AppColors.success,
            Icons.check_circle_outline
          ),
        AppMessageType.warning => (
            AppColors.warningSurface,
            AppColors.warning,
            Icons.warning_amber_outlined
          ),
        AppMessageType.info =>
          (AppColors.infoSurface, AppColors.info, Icons.info_outline),
      };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, icon) = _style;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: fg.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: AppFonts.bodyMedium.copyWith(color: fg)),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, size: 16, color: fg),
            ),
        ],
      ),
    );
  }
}