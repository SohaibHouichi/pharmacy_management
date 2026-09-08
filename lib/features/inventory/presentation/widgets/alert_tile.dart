import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicine_status_x.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class AlertTile extends StatelessWidget {
  final MedicineEntity medicine;
  final VoidCallback onUpdateStock;

  const AlertTile({
    super.key,
    required this.medicine,
    required this.onUpdateStock,
  });

  String get _expiry {
    final date = medicine.expiryDate;
    if (date == null) return '—';
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
                    Text(
                      medicine.category?.name ?? '—',
                      style: AppFonts.caption,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${medicine.quantity}',
                    style: AppFonts.titleMedium.copyWith(
                      color: medicine.isLowStock
                          ? AppColors.error
                          : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '/${medicine.minStockLevel}',
                    style: AppFonts.caption,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.event_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 5),
              Text('Expires $_expiry', style: AppFonts.caption),
            ],
          ),
          if (medicine.badges.isNotEmpty) ...[
            const SizedBox(height: 8),
            StatusBadgeRow(styles: medicine.badges),
          ],
          const SizedBox(height: 10),
          if (medicine.isLowStock) ...[
            const Divider(height: 1),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onUpdateStock,
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Update stock'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
