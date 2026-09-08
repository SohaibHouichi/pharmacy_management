import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/shared/widgets/app_state_view.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/alert_tab_bar.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/alert_tile.dart';

class InventoryPage extends GetView<InventoryController> {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // No Scaffold — MainPage owns it.
    return Column(
      children: [
        const AlertTabBar(),
        Expanded(child: Obx(() => _buildBody())),
      ],
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value && controller.alerts.value == null) {
      return const AppLoadingView();
    }

    final error = controller.errorMessage.value;
    if (error != null && controller.alerts.value == null) {
      return AppErrorView(message: error, onRetry: controller.load);
    }

    final medicines = controller.visibleMedicines;

    if (medicines.isEmpty) {
      return RefreshIndicator(
        color: AppColors.primary,
        onRefresh: controller.load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 80),
            AppEmptyView(
              message: AppConstants.emptyAlertsMessage,
              icon: Icons.check_circle_outline,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: controller.load,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: medicines.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final medicine = medicines[i];
          return AlertTile(
            medicine: medicine,
            onUpdateStock: () => controller.openStockForm(medicine),
          );
        },
      ),
    );
  }
}