import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/domain/expiry_status.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';

/// How a single status renders: label, colors, icon.
class StatusStyle {
  final String label;
  final Color color;
  final Color surface;
  final IconData icon;

  const StatusStyle({
    required this.label,
    required this.color,
    required this.surface,
    required this.icon,
  });
}

/// Shared status styles — used by medicines, inventory, and sales.
class StatusConfig {
  const StatusConfig._();

  static const StatusStyle lowStock = StatusStyle(
    label: 'Low stock',
    color: AppColors.warning,
    surface: AppColors.warningSurface,
    icon: Icons.trending_down,
  );

  static const StatusStyle outOfStock = StatusStyle(
    label: 'Out of stock',
    color: AppColors.error,
    surface: AppColors.errorSurface,
    icon: Icons.remove_shopping_cart_outlined,
  );

  static const StatusStyle inStock = StatusStyle(
    label: 'In stock',
    color: AppColors.success,
    surface: AppColors.successSurface,
    icon: Icons.check_circle_outline,
  );

  static const StatusStyle expired = StatusStyle(
    label: 'Expired',
    color: AppColors.error,
    surface: AppColors.errorSurface,
    icon: Icons.dangerous_outlined,
  );

  static const StatusStyle expiringSoon = StatusStyle(
    label: 'Expiring soon',
    color: AppColors.warning,
    surface: AppColors.warningSurface,
    icon: Icons.schedule,
  );

  static const StatusStyle valid = StatusStyle(
    label: 'Valid',
    color: AppColors.success,
    surface: AppColors.successSurface,
    icon: Icons.verified_outlined,
  );

  static const StatusStyle unknown = StatusStyle(
    label: 'Unknown',
    color: AppColors.textSecondary,
    surface: AppColors.surfaceMuted,
    icon: Icons.help_outline,
  );

  static StatusStyle forExpiry(ExpiryStatus status) => switch (status) {
        ExpiryStatus.valid => valid,
        ExpiryStatus.expiringSoon => expiringSoon,
        ExpiryStatus.expired => expired,
        ExpiryStatus.unknown => unknown,
      };
}