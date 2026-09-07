import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/shared/main/presentation/controllers/main_controller.dart';
import 'package:pharmacy_management/core/shared/widgets/lazy_indexed_stack.dart';
import 'package:pharmacy_management/core/shared/widgets/user_main_button.dart';
import 'package:pharmacy_management/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:pharmacy_management/features/inventory/presentation/pages/inventory_page.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_controller.dart';
import 'package:pharmacy_management/features/medicines/presentation/pages/medicines_page.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sales_controller.dart';
import 'package:pharmacy_management/features/sales/presentation/pages/sales_page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title)),
        actions: const [UserMenuButton()],
      ),
      body: Obx(
        () => LazyIndexedStack(
          index: controller.currentIndex.value,
          itemBuilders: [
            (_) => const DashboardPage(),
            (_) => const MedicinesPage(),
            (_) => const SalesPage(),
            (_) => const InventoryPage(),
          ],
        ),
      ),
      floatingActionButton: Obx(() => _buildFab(controller.currentTab)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: AppConstants.dashboardLable,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication_outlined),
              activeIcon: Icon(Icons.medication),
              label: AppConstants.medicinesLable,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: AppConstants.salesLable,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: AppConstants.inventoryLable,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFab(MainTab tab) {
  switch (tab) {
    case MainTab.medicines:
      return FloatingActionButton.extended(
        onPressed: Get.find<MedicinesController>().openAddForm,
        icon: const Icon(Icons.add),
        label: const Text('Add medicine'),
      );

    case MainTab.sales:
      return FloatingActionButton.extended(
        onPressed: Get.find<SalesController>().openNewSale,
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('New sale'),
      );

    case MainTab.dashboard:
    case MainTab.inventory:
      return const SizedBox.shrink();
  }
}
