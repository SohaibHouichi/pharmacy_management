import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_form_controller.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/form/quantity_preview.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/form/quick_adjust_row.dart';
import 'package:pharmacy_management/features/inventory/presentation/widgets/form/stock_medicine_card.dart';

class InventoryFormPage extends GetView<InventoryFormController> {
  const InventoryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pushed above the shell, so it owns its own Scaffold.
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Update stock')),
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

                  StockMedicineCard(medicine: controller.medicine),
                  const SizedBox(height: 24),

                  AppTextField(
                    controller: controller.quantityCtrl,
                    label: 'New quantity',
                    hint: 'e.g. 120',
                    prefixIcon: Icons.inventory_2_outlined,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: controller.validateQuantity,
                    onChanged: controller.onQuantityChanged,
                    onSubmitted: (_) => controller.submit(),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'This replaces the current quantity, it is not added to it.',
                      style: AppFonts.caption,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const QuickAdjustRow(),
                  const SizedBox(height: 20),

                  const QuantityPreview(),
                  const SizedBox(height: 32),

                  AppButton(
                    label: 'Save',
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
