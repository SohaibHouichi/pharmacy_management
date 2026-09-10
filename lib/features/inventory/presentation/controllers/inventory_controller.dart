import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/dashboard/dashboard.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_alerts_entity.dart';
import 'package:pharmacy_management/features/inventory/domain/usecase/get_inventory_alerts.dart';
import 'package:pharmacy_management/features/medicines/medicines.dart';

enum InventoryTab { all, lowStock, expiringSoon, expired }

class InventoryController extends GetxController {
  final GetInventoryAlerts getInventoryAlerts;
  final GetMedicines getMedicines;

  InventoryController({
    required this.getInventoryAlerts,
    required this.getMedicines,
  });

  final Rxn<InventoryAlertsEntity> alerts = Rxn<InventoryAlertsEntity>();
  final medicines = <MedicineEntity>[].obs;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = RxnString();
  final selectedTab = InventoryTab.all.obs;
  final totalMedicines = 0.obs;

  final _currentPage = 1.obs;
  final _lastPage = 1.obs;

  /// Only the "all" tab paginates — alert lists arrive complete.
  bool get hasNextPage =>
      selectedTab.value == InventoryTab.all && _currentPage.value < _lastPage.value;

  bool get isEmpty =>
      visibleMedicines.isEmpty &&
      !isLoading.value &&
      errorMessage.value == null;

  /// The medicines shown for the currently selected tab.
  List<MedicineEntity> get visibleMedicines {
    if (selectedTab.value == InventoryTab.all) return medicines;

    final data = alerts.value;
    if (data == null) return const [];

    return switch (selectedTab.value) {
      InventoryTab.lowStock => data.lowStock,
      InventoryTab.expiringSoon => data.expiringSoon,
      InventoryTab.expired => data.expired,
      InventoryTab.all => medicines,
    };
  }

  int countFor(InventoryTab tab) {
    if (tab == InventoryTab.all) return totalMedicines.value;

    final data = alerts.value;
    if (data == null) return 0;

    return switch (tab) {
      InventoryTab.lowStock => data.lowStock.length,
      InventoryTab.expiringSoon => data.expiringSoon.length,
      InventoryTab.expired => data.expired.length,
      InventoryTab.all => totalMedicines.value,
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

    final alertsResult = await getInventoryAlerts();
    final medicinesResult = await getMedicines(page: 1);

    isLoading.value = false;

    alertsResult.fold(
      (failure) => errorMessage.value = failure.message,
      (data) => alerts.value = data,
    );

    medicinesResult.fold(
      (failure) => errorMessage.value = failure.message,
      (page) {
        medicines.value = page.items;
        _applyMeta(page);
      },
    );
  }

  Future<void> loadNextPage() async {
    // Guard against the scroll listener double-firing.
    if (isLoadingMore.value || isLoading.value || !hasNextPage) return;

    isLoadingMore.value = true;
    final result = await getMedicines(page: _currentPage.value + 1);
    isLoadingMore.value = false;

    result.fold(
      // A failed append shouldn't wipe the list already on screen.
      (failure) => Get.snackbar('Error', failure.message),
      (page) {
        medicines.addAll(page.items);
        _applyMeta(page);
      },
    );
  }

  void _applyMeta(Paginated<MedicineEntity> page) {
    _currentPage.value = page.meta.currentPage;
    _lastPage.value = page.meta.lastPage;
    totalMedicines.value = page.meta.total;
  }

  void changeTab(InventoryTab tab) => selectedTab.value = tab;

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