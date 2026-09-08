import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/dialogs/logout_dialog.dart';
import 'package:pharmacy_management/features/shell/presentation/controllers/main_controller.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class UserMenuButton extends GetView<MainController> {
  const UserMenuButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopupMenuButton<String>(
        offset: const Offset(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: AppColors.surface,
        onSelected: (value) {
          if (value == 'logout') LogoutDialog().confirmLogout(context);
        },
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.user?.name ?? '—', style: AppFonts.titleMedium),
                const SizedBox(height: 2),
                Text(controller.user?.email ?? '', style: AppFonts.caption),
              ],
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, size: 18, color: AppColors.error),
                SizedBox(width: 10),
                Text('Log out', style: TextStyle(color: AppColors.error)),
              ],
            ),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.primarySurface,
            child: controller.isLoggingOut.value
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    controller.initial,
                    style: AppFonts.label.copyWith(color: AppColors.primary),
                  ),
          ),
        ),
      ),
    );
  }
}