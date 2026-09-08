import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_status_x.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class HeaderCard extends StatelessWidget {
  final MedicineEntity medicine;
  const HeaderCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            medicine.name,
            style: AppFonts.headingMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(medicine.category?.name ?? '—', style: AppFonts.bodyMuted),
          const SizedBox(height: 14),
          Text(
            medicine.price.toStringAsFixed(2),
            style: AppFonts.headingLarge.copyWith(color: AppColors.primary),
          ),
          if (medicine.badges.isNotEmpty) ...[
            const SizedBox(height: 14),
            StatusBadgeRow(
              styles: medicine.badges,
              showIcons: true,
              alignment: WrapAlignment.center,
            ),
          ],
        ],
      ),
    );
  }
}
