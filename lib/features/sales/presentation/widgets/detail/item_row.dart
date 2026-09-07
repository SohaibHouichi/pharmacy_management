

import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';

class ItemRow extends StatelessWidget {
  final SaleItemEntity item;
  const ItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppFonts.label.copyWith(
                    // A deleted medicine keeps its name greyed out.
                    color: item.medicineDeleted
                        ? AppColors.textHint
                        : AppColors.textPrimary,
                    fontStyle:
                        item.medicineDeleted ? FontStyle.italic : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.quantity} × ${item.unitPrice.toStringAsFixed(2)}',
                  style: AppFonts.caption,
                ),
              ],
            ),
          ),
          Text(item.total.toStringAsFixed(2), style: AppFonts.label),
        ],
      ),
    );
  }
}