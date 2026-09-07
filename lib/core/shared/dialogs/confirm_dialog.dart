import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';

class ConfirmDialog {
  const ConfirmDialog._();

  /// Returns true only when the user explicitly confirms.
  static Future<bool> show({
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor:
                  isDestructive ? AppColors.error : AppColors.primary,
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    // Dismissing by tapping outside returns null — treat as cancel.
    return result ?? false;
  }
}