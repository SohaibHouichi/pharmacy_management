import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/features/shell/shell.dart';
import 'package:pharmacy_management/features/dashboard/dashboard.dart';
import 'package:pharmacy_management/features/inventory/inventory.dart';
import 'package:pharmacy_management/features/medicines/medicines.dart';
import 'package:pharmacy_management/features/sales/sales.dart';

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
              label: AppConstants.dashboardLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication_outlined),
              activeIcon: Icon(Icons.medication),
              label: AppConstants.medicinesLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: AppConstants.salesLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: AppConstants.inventoryLabel,
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
