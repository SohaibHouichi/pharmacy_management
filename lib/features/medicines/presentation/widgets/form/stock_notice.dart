import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class StockNotice extends StatelessWidget {
  const StockNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.infoSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 18, color: AppColors.info),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Stock quantity is updated from the Inventory tab.',
              style: AppFonts.bodyMedium.copyWith(color: AppColors.info),
            ),
          ),
        ],
      ),
    );
  }
}
