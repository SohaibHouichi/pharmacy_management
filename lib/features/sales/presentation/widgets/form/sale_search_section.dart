import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sale_form_controller.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/medicine_search_results.dart';

/// Stateless — the TextEditingController lives in SaleFormController,
/// which disposes it in onClose.
class SaleSearchSection extends GetView<SaleFormController> {
  const SaleSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        children: [
          TextField(
            controller: controller.searchController,
            onChanged: controller.searchMedicines,
            style: AppFonts.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Search a medicine to add…',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: AppColors.surface,
              suffixIcon: Obx(
                () => controller.isSearching.value
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          const MedicineSearchResults(),
        ],
      ),
    );
  }
}