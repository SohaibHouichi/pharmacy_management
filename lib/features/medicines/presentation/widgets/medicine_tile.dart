import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_status_x.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/presentation/widgets/actions_menu.dart';

class MedicineTile extends StatelessWidget {
  final MedicineEntity medicine;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MedicineTile({
    super.key,
    required this.medicine,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: medicine.isExpired || medicine.quantity == 0
                  ? AppColors.error
                  : medicine.isExpiringSoon || medicine.isLowStock
                  ? AppColors.warning
                  : AppColors.primary,
                  width: 2
            ),
            
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: medicine.isExpired || medicine.quantity == 0
                    ? AppColors.errorSurface
                    : medicine.isExpiringSoon || medicine.isLowStock
                    ? AppColors.warningSurface
                    : AppColors.primarySurface,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: medicine.isExpired || medicine.quantity == 0
                    ? AppColors.error
                    : medicine.isExpiringSoon || medicine.isLowStock
                    ? AppColors.warning
                    : AppColors.primary,
                size: 22,
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
                  const SizedBox(height: 3),
                  Text(medicine.category?.name ?? '—', style: AppFonts.caption),
                  if (medicine.badges.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    StatusBadgeRow(styles: medicine.badges),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      medicine.price.toStringAsFixed(2),
                      style: AppFonts.titleMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    ActionsMenu(onEdit: onEdit, onDelete: onDelete),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'Qty ${medicine.quantity}',
                    style: AppFonts.caption,
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
