import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicine_form_controller.dart';
import 'package:pharmacy_management/features/medicines/presentation/widgets/form/stock_notice.dart';

class MedicineFormPage extends GetView<MedicineFormController> {
  const MedicineFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(controller.pageTitle)),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Obx(
            () => Form(
              key: controller.formKey,
              autovalidateMode: controller.autovalidateMode.value,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                children: [
                  if (controller.errorMessage.value != null) ...[
                    AppMessageBanner(
                      message: controller.errorMessage.value!,
                      onDismiss: controller.clearErrors,
                    ),
                    const SizedBox(height: 20),
                  ],

                  AppTextField(
                    controller: controller.nameCtrl,
                    label: AppConstants.nameLabel,
                    hint: 'e.g. Paracetamol 500mg',
                    prefixIcon: Icons.medication_outlined,
                    validator: controller.validateName,
                    onChanged: (_) => controller.clearFieldError('name'),
                  ),
                  const SizedBox(height: 18),

                  AppDropdownField<int>(
                    label: AppConstants.categoryLabel,
                    hint: controller.isLoadingCategories.value
                        ? 'Loading…'
                        : 'Select a category',
                    value: controller.selectedCategoryId.value,
                    errorText: controller.categoryError,
                    enabled: !controller.isLoadingCategories.value,
                    prefixIcon: Icons.category_outlined,
                    onChanged: controller.onCategoryChanged,
                    items: controller.categories
                        .map((c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 18),

                  AppTextField(
                    controller: controller.priceCtrl,
                    label: AppConstants.priceLabel,
                    hint: 'e.g. 8.50',
                    prefixIcon: Icons.payments_outlined,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: controller.validatePrice,
                    onChanged: (_) => controller.clearFieldError('price'),
                  ),
                  const SizedBox(height: 18),

                  // Quantity is create-only; edits go through inventory.
                  if (!controller.isEditing) ...[
                    AppTextField(
                      controller: controller.quantityCtrl,
                      label: AppConstants.quantityLabel,
                      hint: 'e.g. 120',
                      prefixIcon: Icons.numbers,
                      keyboardType: TextInputType.number,
                      validator: controller.validateQuantity,
                      onChanged: (_) => controller.clearFieldError('quantity'),
                    ),
                    const SizedBox(height: 18),
                  ] else
                    const StockNotice(),

                  AppDateField(
                    label: AppConstants.expiryDateLabel,
                    hint: 'Select expiry date',
                    value: controller.expiryDate.value,
                    errorText: controller.expiryError,
                    onChanged: controller.onExpiryChanged,
                  ),
                  const SizedBox(height: 32),

                  AppButton(
                    label: controller.submitLabel,
                    isLoading: controller.isSaving.value,
                    onPressed: controller.submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
