import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/features/medicines/medicines.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_params.dart';
import 'package:pharmacy_management/features/sales/domain/usecase/create_sale.dart';

/// A medicine plus the quantity being sold.
class CartLine {
  final MedicineEntity medicine;
  int quantity;

  CartLine({required this.medicine, this.quantity = 1});

  double get total => medicine.price * quantity;
  bool get exceedsStock => quantity > medicine.quantity;
}

class SaleFormController extends GetxController {
  final CreateSale createSale;
  final GetMedicines getMedicines;

  SaleFormController({required this.createSale, required this.getMedicines});

  final cart = <CartLine>[].obs;
  final searchResults = <MedicineEntity>[].obs;
  final searchController = TextEditingController();

  final isSearching = false.obs;
  final isSaving = false.obs;
  final errorMessage = RxnString();

  bool get canSubmit => cart.isNotEmpty && !cart.any((l) => l.exceedsStock);

  /// Client-side preview only — the server's total is authoritative.
  double get estimatedTotal => cart.fold(0, (sum, line) => sum + line.total);

  Future<void> searchMedicines(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isSearching.value = true;
    final result = await getMedicines(query: query, page: 1);
    isSearching.value = false;

    result.fold(
      (failure) => errorMessage.value = failure.message,
      (page) => searchResults.value = page.items,
    );
  }

  void addToCart(MedicineEntity medicine) {
    final existing = cart.indexWhere((l) => l.medicine.id == medicine.id);
    if (existing >= 0) {
      changeQuantity(existing, cart[existing].quantity + 1);
      return;
    }
    cart.add(CartLine(medicine: medicine));
    clearSearch();
  }

  void changeQuantity(int index, int quantity) {
    if (quantity < 1) return;
    cart[index].quantity = quantity;
    cart.refresh();
  }

  void removeLine(int index) => cart.removeAt(index);

  Future<void> submit() async {
    if (!canSubmit) return;

    isSaving.value = true;
    errorMessage.value = null;

    final result = await createSale(
      CreateSaleParam(
        items: cart
            .map(
              (l) => SaleParam(medicineId: l.medicine.id, quantity: l.quantity),
            )
            .toList(),
      ),
    );

    isSaving.value = false;

    result.fold(
      // 422 here means insufficient stock or expired medicine.
      (failure) => errorMessage.value = failure.message,
      (sale) {
        Get.back(result: true);
        Get.snackbar('Sale created', 'Invoice ${sale.invoiceNumber}');
        Get.find<MedicinesController>().refreshList();
      },
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
  }
}
