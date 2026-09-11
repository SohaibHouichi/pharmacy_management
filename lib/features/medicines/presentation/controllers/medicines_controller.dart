import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/features/dashboard/dashboard.dart';
import 'package:pharmacy_management/features/inventory/inventory.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/delete_medicine.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_medicines.dart';

class MedicinesController extends GetxController {
  final GetMedicines getMedicines;
  final DeleteMedicine deleteMedicine;

  MedicinesController({
    required this.getMedicines,
    required this.deleteMedicine,
  });

  final items = <MedicineEntity>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = RxnString();
  final searchQuery = ''.obs;
  final total = 0.obs;
  final deletingId = RxnInt();
  final searchController = TextEditingController();

  final _currentPage = 1.obs;
  final _lastPage = 1.obs;
  Worker? _searchWorker;

  bool get hasNextPage => _currentPage.value < _lastPage.value;
  bool get isEmpty =>
      items.isEmpty && !isLoading.value && errorMessage.value == null;

  @override
  void onInit() {
    super.onInit();

    // Debounce so typing doesn't fire a request per keystroke.
    _searchWorker = debounce(
      searchQuery,
      (_) => loadFirstPage(),
      time: AppConstants.searchDebounce,
    );

    loadFirstPage();
  }

  @override
  void onClose() {
    _searchWorker?.dispose();
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadFirstPage() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await getMedicines(query: searchQuery.value, page: 1);

    isLoading.value = false;
    result.fold((failure) => errorMessage.value = failure.message, (page) {
      items.value = page.items;
      _applyMeta(page);
    });
  }

  Future<void> loadNextPage() async {
    // Guard against the scroll listener double-firing.
    if (isLoadingMore.value || isLoading.value || !hasNextPage) return;

    isLoadingMore.value = true;
    final result = await getMedicines(
      query: searchQuery.value,
      page: _currentPage.value + 1,
    );
    isLoadingMore.value = false;

    result.fold(
      // A failed append shouldn't wipe the list already on screen.
      (failure) => Get.snackbar('Error', failure.message),
      (page) {
        items.addAll(page.items);
        _applyMeta(page);
      },
    );
  }

  void _applyMeta(Paginated<MedicineEntity> page) {
    _currentPage.value = page.meta.currentPage;
    _lastPage.value = page.meta.lastPage;
    total.value = page.meta.total;
  }

  Future<void> refreshList() async {
    await loadFirstPage();
    await _refreshDashboard();
    await _refreshInventory();
  }

  /// The dashboard's totals depend on medicines, so resync it after changes.
  Future<void> _refreshDashboard() async {
    if (Get.isRegistered<DashboardController>()) {
      await Get.find<DashboardController>().loadDashboard();
    }
  }

  Future<void> _refreshInventory() async {
    if (Get.isRegistered<InventoryController>()) {
      await Get.find<InventoryController>().load();
    }
  }

  void onSearchChanged(String value) => searchQuery.value = value;

 void clearSearch() {
  searchController.clear();
  searchQuery.value = '';
}

  Future<void> openDetails(int id) async {
    await Get.toNamed(AppRoute.medicineDetail, arguments: id);
  }

  Future<void> openAddForm() async {
    final saved = await Get.toNamed(AppRoute.medicineForm);
    if (saved == true) await refreshList();
  }

  Future<void> openEditForm(MedicineEntity medicine) async {
    final saved = await Get.toNamed(AppRoute.medicineForm, arguments: medicine);
    if (saved == true) await refreshList();
  }

  Future<void> confirmDelete(MedicineEntity medicine) async {
    final confirmed = await ConfirmDialog.show(
      title: 'Delete medicine',
      message: 'Delete "${medicine.name}"? This cannot be undone.',
      confirmLabel: 'Delete',
      isDestructive: true,
    );
    if (!confirmed) return;

    deletingId.value = medicine.id;
    final result = await deleteMedicine(medicine.id);
    deletingId.value = null;

    result.fold((failure) => Get.snackbar('Error', failure.message), (_) async {
      // Remove locally so the list doesn't flicker, then resync counts.
      items.removeWhere((m) => m.id == medicine.id);
      total.value = (total.value - 1).clamp(0, total.value);
      await  refreshList();
      Get.snackbar('Deleted', '${medicine.name} removed');
    });
  }
}
