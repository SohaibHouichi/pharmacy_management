import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/inventory_tab_bar.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/inventory_tile.dart';
import 'package:pharmacy_management/features/medicines/medicines.dart';

class InventoryPage extends GetView<InventoryController> {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // No Scaffold — MainPage owns it.
    return Column(
      children: [
        const InventoryTabBar(),
        Expanded(child: Obx(() => _buildBody())),
      ],
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value && controller.visibleMedicines.isEmpty) {
      return const AppLoadingView();
    }

    final error = controller.errorMessage.value;
    if (error != null && controller.visibleMedicines.isEmpty) {
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

    return PaginatedListView<MedicineEntity>(
      // Rebuild the scroll controller when switching tabs, so position resets.
      key: ValueKey(controller.selectedTab.value),
      items: medicines,
      isLoadingMore: controller.isLoadingMore.value,
      hasNextPage: controller.hasNextPage,
      onRefresh: controller.load,
      onLoadMore: controller.loadNextPage,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemBuilder: (_, medicine, __) => InventoryTile(
        medicine: medicine,
        onUpdateStock: () => controller.openStockForm(medicine),
      ),
    );
  }
}
