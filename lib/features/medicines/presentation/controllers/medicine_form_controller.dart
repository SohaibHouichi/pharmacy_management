import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/category_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_params.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/add_medicine.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/get_categories.dart';
import 'package:pharmacy_management/features/medicines/domain/usecase/update_medicine.dart';

class MedicineFormController extends GetxController with FormErrorsMixin {
  final AddMedicine addMedicine;
  final UpdateMedicine updateMedicine;
  final GetCategories getCategories;

  MedicineFormController({
    required this.addMedicine,
    required this.updateMedicine,
    required this.getCategories,
  });

  /// Passed via Get.arguments — null when adding a new medicine.
  MedicineEntity? editing;

  bool get isEditing => editing != null;
  String get pageTitle => isEditing ? 'Edit medicine' : 'Add medicine';
  String get submitLabel => isEditing ? 'Save changes' : 'Add medicine';

  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();

  final categories = <CategoryEntity>[].obs;
  final selectedCategoryId = RxnInt();
  final expiryDate = Rxn<DateTime>();
  final isLoadingCategories = false.obs;
  final isSaving = false.obs;

  late final validateName = validator('name', [
    Validators.required(AppConstants.nameLabel),
    Validators.minLength(2, AppConstants.nameLabel),
  ]);

  late final validatePrice = validator('price', [
    Validators.required(AppConstants.priceLabel),
    Validators.positiveNumber(AppConstants.priceLabel),
  ]);

  late final validateQuantity = validator('quantity', [
    Validators.required(AppConstants.quantityLabel),
    Validators.wholeNumber(AppConstants.quantityLabel),
  ]);

  String? get categoryError => fieldErrors['category_id']?.first;
  String? get expiryError => fieldErrors['expiry_date']?.first;

  @override
  void onInit() {
    super.onInit();
    editing = Get.arguments as MedicineEntity?;
    _prefill();
    loadCategories();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    quantityCtrl.dispose();
    super.onClose();
  }

  void _prefill() {
    final medicine = editing;
    if (medicine == null) return;

    nameCtrl.text = medicine.name;
    priceCtrl.text = medicine.price.toString();
    selectedCategoryId.value = medicine.categoryId;
    expiryDate.value = medicine.expiryDate;
    // Quantity isn't prefilled — it isn't editable here.
  }

  Future<void> loadCategories() async {
    isLoadingCategories.value = true;
    final result = await getCategories();
    isLoadingCategories.value = false;

    result.fold(
      (failure) => errorMessage.value = failure.message,
      (list) => categories.value = list ,
    );
  }

  void onCategoryChanged(int? id) {
    selectedCategoryId.value = id;
    clearFieldError('category_id');
  }

  void onExpiryChanged(DateTime date) {
    expiryDate.value = date;
    clearFieldError('expiry_date');
  }

  Future<void> submit() async {
    if (!validateForm()) return;

    // Dropdown and date picker sit outside the Form, so check them here.
    if (selectedCategoryId.value == null) {
      fieldErrors['category_id'] = ['Please select a category'];
      return;
    }
    if (expiryDate.value == null) {
      fieldErrors['expiry_date'] = ['Please select an expiry date'];
      return;
    }

    isSaving.value = true;

    final result = isEditing
        ? await updateMedicine(
            editing!.id,
            UpdateMedicineParams(
              name: nameCtrl.text.trim(),
              categoryId: selectedCategoryId.value!,
              price: double.parse(priceCtrl.text.trim()),
              expiryDate: expiryDate.value!,
            ),
          )
        : await addMedicine(
            CreateMedicineParams(
              name: nameCtrl.text.trim(),
              categoryId: selectedCategoryId.value!,
              price: double.parse(priceCtrl.text.trim()),
              quantity: int.parse(quantityCtrl.text.trim()),
              expiryDate: expiryDate.value!,
            ),
          );

    isSaving.value = false;

    result.fold(handleFailure, (_) {
      // `true` tells the list to refresh.
      Get.back(result: true);
      Get.snackbar('Saved', isEditing ? 'Medicine updated' : 'Medicine added');
    });
  }
}