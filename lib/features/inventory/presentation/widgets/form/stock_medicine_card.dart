import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_status_x.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class StockMedicineCard extends StatelessWidget {
  final MedicineEntity medicine;

  const StockMedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: AppFonts.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  '${medicine.category?.name ?? '—'} · '
                  'min ${medicine.minStockLevel}',
                  style: AppFonts.caption,
                ),
                if (medicine.badges.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  StatusBadgeRow(styles: medicine.badges),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}