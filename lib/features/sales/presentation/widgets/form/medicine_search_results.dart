import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sale_form_controller.dart';

class MedicineSearchResults extends GetView<SaleFormController> {
  const MedicineSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.searchResults.isEmpty) return const SizedBox.shrink();

      return Container(
        margin: const EdgeInsets.only(top: 6),
        constraints: const BoxConstraints(maxHeight: 220),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.searchResults.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final medicine = controller.searchResults[i];
                final outOfStock = medicine.quantity == 0;

                return ListTile(
                  dense: true,
                  enabled: !outOfStock,
                  title: Text(medicine.name, style: AppFonts.bodyMedium),
                  subtitle: Text(
                    outOfStock
                        ? 'Out of stock'
                        : 'Stock ${medicine.quantity} · '
                              '${medicine.price.toStringAsFixed(2)}',
                    style: AppFonts.caption.copyWith(
                      color: outOfStock ? AppColors.error : null,
                    ),
                  ),
                  trailing: const Icon(Icons.add, size: 18),
                  onTap: outOfStock
                      ? null
                      : () => controller.addToCart(medicine),
                );
              },
            ),
          ),
        ),
      ) ;
    });
  }
}
