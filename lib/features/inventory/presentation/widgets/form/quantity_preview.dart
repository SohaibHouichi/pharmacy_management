import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_form_controller.dart';

/// Shows current → new so the pharmacist sees the change before saving.
class QuantityPreview extends GetView<InventoryFormController> {
  const QuantityPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final delta = controller.delta.value;
      final unchanged = delta == 0;

      final deltaColor = unchanged
          ? AppColors.textSecondary
          : delta > 0
              ? AppColors.success
              : AppColors.error;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Figure(
              label: 'Current',
              value: '${controller.currentQuantity}',
            ),
            const Icon(
              Icons.arrow_forward,
              size: 18,
              color: AppColors.textSecondary,
            ),
            _Figure(
              label: 'New',
              value: '${controller.newQuantity.value}',
              color: AppColors.primary,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                unchanged ? 'no change' : controller.deltaLabel,
                style: AppFonts.label.copyWith(color: deltaColor),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Figure extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _Figure({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: AppFonts.caption),
        const SizedBox(height: 2),
        Text(value, style: AppFonts.headingMedium.copyWith(color: color)),
      ],
    );
  }
}