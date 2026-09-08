import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_controller.dart';

class MedicineSearchField extends GetView<MedicinesController> {
  const MedicineSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.onSearchChanged,
      style: AppFonts.bodyLarge,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search medicines…',
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: Obx(
          () => controller.searchQuery.value.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: controller.clearSearch,
                ),
        ),
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }
}