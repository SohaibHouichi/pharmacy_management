import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';

class SaleTile extends StatelessWidget {
  final SaleEntity sale;
  final VoidCallback? onTap;

  const SaleTile({super.key, required this.sale, this.onTap});

  String get _date {
    final date = sale.createdAt;
    if (date == null) return '';
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

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
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.infoSurface,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.info,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sale.invoiceNumber,
                    style: AppFonts.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(_date, style: AppFonts.caption),
                  const SizedBox(height: 3),
                  Text(
                    '${sale.itemCount} items · ${sale.totalUnits} units',
                    style: AppFonts.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              sale.total.toStringAsFixed(2),
              style: AppFonts.titleMedium.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}