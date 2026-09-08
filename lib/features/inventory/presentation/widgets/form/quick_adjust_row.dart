import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_form_controller.dart';

/// Shortcuts for common restock amounts.
class QuickAdjustRow extends GetView<InventoryFormController> {
  const QuickAdjustRow({super.key});

  static const _steps = [-10, -1, 1, 10, 50];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _steps.map((step) {
        final isNegative = step < 0;
        return InkWell(
          onTap: () => controller.adjustBy(step),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              isNegative ? '$step' : '+$step',
              style: AppFonts.label.copyWith(
                color: isNegative ? AppColors.error : AppColors.primary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}