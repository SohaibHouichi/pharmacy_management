import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/features/shell/presentation/controllers/main_controller.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';

class LogoutDialog extends GetxController {
  final MainController controller = Get.find<MainController>();

  Future<void> confirmLogout(BuildContext context) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed == true) await controller.logout();
  }
}