
import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_status_x.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/core/shared/widgets/detail_row.dart';

class InfoCard extends StatelessWidget {
  final MedicineEntity medicine;
  const InfoCard({super.key, required this.medicine});

  String get _expiryText {
    final date = medicine.expiryDate;
    if (date == null) return '—';
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Color get _quantityColor =>
      medicine.isLowStock ? AppColors.error : AppColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          DetailRow(
            icon: Icons.inventory_2_outlined,
            label: 'Quantity in stock',
            value: '${medicine.quantity}',
            valueColor: _quantityColor,
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.trending_down,
            label: 'Minimum stock level',
            value: '${medicine.minStockLevel}',
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.event_outlined,
            label: 'Expiry date',
            value: _expiryText,
            // Shared config decides the colour for each expiry status.
            valueColor: medicine.expiryStyle.color,
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.category_outlined,
            label: 'Category',
            value: medicine.category!.name,
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.info_outline,
            label: 'Status',
            value: medicine.expiryStatus.toStrings,
              // Shared config decides the colour for each expiry status.
            valueColor: medicine.expiryStyle.color,
          ),
        ],
      ),
    );
  }
}