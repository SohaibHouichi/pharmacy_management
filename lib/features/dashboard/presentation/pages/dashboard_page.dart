import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/shared/widgets/app_state_view.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/greeting.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/low_stock_section.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/stat_grid.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.dashboard.value == null) {
        return const AppLoadingView();
      }

      final error = controller.errorMessage.value;
      if (error != null && controller.dashboard.value == null) {
        return AppErrorView(message: error, onRetry: controller.loadDashboard);
      }

      final data = controller.dashboard.value;
      if (data == null) {
        return const AppEmptyView(message: AppConstants.emptyDashboard);
      }

      return RefreshIndicator(
        color: AppColors.primary,
        onRefresh: controller.refreshDashboard,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Greeting(name: controller.user?.name),
            const SizedBox(height: 20),
            StatsGrid(data: data),
            const SizedBox(height: 28),
            LowStockSection(data: data),
          ],
        ),
      );
    });
  }
}



