import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class LowStockTile extends StatelessWidget {
  final MedicineEntity medicine;
  final VoidCallback? onTap;

  const LowStockTile({super.key, required this.medicine, this.onTap});

  @override
  Widget build(BuildContext context) {
  //  final expiringSoon = medicine.isExpiringSoon || medicine.isExpired;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.warningSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.medication_outlined,
                color: AppColors.warning,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: AppFonts.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                medicine.quantity == 0
                    ? StatusBadge(style: StatusConfig.outOfStock)
                    : Text(
                        '${medicine.quantity}',
                        style: AppFonts.caption.copyWith(
                          color: AppColors.error,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
