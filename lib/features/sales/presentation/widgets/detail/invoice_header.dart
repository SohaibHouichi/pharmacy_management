import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';

class InvoiceHeader extends StatelessWidget {
  final SaleEntity sale;
  const InvoiceHeader({super.key, required this.sale});

  String get _date {
    final date = sale.createdAt;
    if (date == null) return '—';
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.infoSurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: AppColors.info,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            sale.invoiceNumber,
            style: AppFonts.headingMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(_date, style: AppFonts.bodyMuted),
          const SizedBox(height: 14),
          Text(
            sale.total.toStringAsFixed(2),
            style: AppFonts.headingLarge.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}