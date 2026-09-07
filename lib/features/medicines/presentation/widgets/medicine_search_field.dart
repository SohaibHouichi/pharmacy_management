import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_controller.dart';

class MedicineSearchField extends StatefulWidget {
  final MedicinesController controller;

  const MedicineSearchField({super.key, required this.controller});

  @override
  State<MedicineSearchField> createState() => _MedicineSearchFieldState();
}

class _MedicineSearchFieldState extends State<MedicineSearchField> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: widget.controller.onSearchChanged,
      style: AppFonts.bodyLarge,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search medicines…',
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: Obx(
          () => widget.controller.searchQuery.value.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () {
                    _textController.clear();
                    widget.controller.clearSearch();
                  },
                ),
        ),
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }
}