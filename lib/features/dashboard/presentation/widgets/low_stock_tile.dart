import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/config/status_style.dart';
import 'package:pharmacy_management/core/shared/widgets/app_state_view.dart';
import 'package:pharmacy_management/core/shared/widgets/status_badge.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class LowStockTile extends StatelessWidget {
  final MedicineEntity medicine;
  final VoidCallback? onTap;

  const LowStockTile({super.key, required this.medicine, this.onTap});

  @override
  Widget build(BuildContext context) {
    final expiringSoon = medicine.isExpiringSoon || medicine.isExpired;

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
                medicine.quantity == 0 ?
                StatusBadge(style: StatusConfig.outOfStock)
                :Text( 
                  'Still only ${medicine.quantity}',
                  style: AppFonts.caption.copyWith(color: AppColors.error),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
