import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_alerts_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/usecase/get_inventory_alerts.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_controller.dart';

enum AlertTab { lowStock, expiringSoon, expired }

class InventoryController extends GetxController {
  final GetInventoryAlerts getInventoryAlerts;

  InventoryController({required this.getInventoryAlerts});

  final Rxn<InventoryAlertsEntity> alerts = Rxn<InventoryAlertsEntity>();
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final selectedTab = AlertTab.lowStock.obs;

  bool get isEmpty =>
      alerts.value == null && !isLoading.value && errorMessage.value == null;

  /// The medicines shown for the currently selected tab.
  List<MedicineEntity> get visibleMedicines {
    final data = alerts.value;
    if (data == null) return const [];

    return switch (selectedTab.value) {
      AlertTab.lowStock => data.lowStock,
      AlertTab.expiringSoon => data.expiringSoon,
      AlertTab.expired => data.expired,
    };
  }

  int countFor(AlertTab tab) {
    final data = alerts.value;
    if (data == null) return 0;

    return switch (tab) {
      AlertTab.lowStock => data.lowStock.length,
      AlertTab.expiringSoon => data.expiringSoon.length,
      AlertTab.expired => data.expired.length,
    };
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await getInventoryAlerts();

    isLoading.value = false;
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) => alerts.value = data,
    );
  }

  void changeTab(AlertTab tab) => selectedTab.value = tab;

  Future<void> openStockForm(MedicineEntity medicine) async {
    final updated = await Get.toNamed(
      AppRoute.inventoryForm,
      arguments: medicine,
    );

    if (updated == true) {
      // Stock changed, so alerts, the dashboard and the list are all stale.
      await load();
      await _refreshOtherTabs();
    }
  }

  Future<void> _refreshOtherTabs() async {
    if (Get.isRegistered<DashboardController>()) {
      await Get.find<DashboardController>().loadDashboard();
    }
    if (Get.isRegistered<MedicinesController>()) {
      await Get.find<MedicinesController>().loadFirstPage();
    }
  }
}