import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/domain/entity/inventory_params.dart';
import 'package:pharmacy_management/features/inventory/domain/usecase/update_stock.dart';
import 'package:pharmacy_management/features/medicines/medicines.dart';

class InventoryFormController extends GetxController with FormErrorsMixin {
  final UpdateStock updateStock;

  InventoryFormController({required this.updateStock});

  late final MedicineEntity medicine;
  final quantityCtrl = TextEditingController();
  final isSaving = false.obs;

  /// Reactive so the preview updates as the user types.
  final newQuantity = 0.obs;
  final delta = 0.obs;

  late final validateQuantity = validator('quantity', [
    Validators.required(AppConstants.quantityLabel),
    Validators.wholeNumber(AppConstants.quantityLabel),
  ]);

  int get currentQuantity => medicine.quantity;

  String get deltaLabel =>
      delta.value > 0 ? '+${delta.value}' : '${delta.value}';

  @override
  void onInit() {
    super.onInit();
    medicine = Get.arguments as MedicineEntity;
    // Prefilled with the current value — this is an absolute quantity.
    quantityCtrl.text = medicine.quantity.toString();
    newQuantity.value = medicine.quantity;
  }

  @override
  void onClose() {
    quantityCtrl.dispose();
    super.onClose();
  }

  void onQuantityChanged(String value) {
    clearFieldError('quantity');
    newQuantity.value = int.tryParse(value.trim()) ?? currentQuantity;
    delta.value = newQuantity.value - currentQuantity;
  }

  void adjustBy(int amount) {
    final next = (newQuantity.value + amount).clamp(0, 999999);
    quantityCtrl.text = next.toString();
    onQuantityChanged(next.toString());
  }

  Future<void> submit() async {
    if (!validateForm()) return;

    isSaving.value = true;

    final result = await updateStock(
      UpdateStockParams(
        medicineId: medicine.id,
        quantity: int.parse(quantityCtrl.text.trim()),
      ),
    );

    isSaving.value = false;

    result.fold(handleFailure, (updated) {
      Get.back(result: true , closeOverlays: true);
      Get.snackbar(
        'Stock updated',
        '${medicine.name}: ${updated.quantityBefore} → ${updated.quantityAfter}',
      );
    });
  }
}