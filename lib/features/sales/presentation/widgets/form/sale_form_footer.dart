import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sale_form_controller.dart';

class SaleFormFooter extends GetView<SaleFormController> {
  const SaleFormFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.errorMessage.value != null) ...[
              AppMessageBanner(
                message: controller.cart.any((i) => i.medicine.isExpired)
                    ? controller.fieldErrors[controller.isMedicineId]!.first
                          .toString()
                    : controller.fieldErrors[controller.isQuantiy]!.first
                          .toString(),
                onDismiss: () => controller.errorMessage.value = null,
              ),
              const SizedBox(height: 14),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimated total', style: AppFonts.bodyMuted),
                Text(
                  controller.estimatedTotal.toStringAsFixed(2),
                  style: AppFonts.headingMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            AppButton(
              label: 'Complete sale (cash)',
              isLoading: controller.isSaving.value,
              onPressed: controller.canSubmit ? controller.submit : null,
            ),
          ],
        ),
      ),
    );
  }
}
