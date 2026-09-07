import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/shared/widgets/detail_row.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';

class SummaryCard extends StatelessWidget {
  final SaleEntity sale;
  const SummaryCard({super.key, required this.sale});

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
            icon: Icons.person_outline,
            label: 'Cashier',
            value: sale.cashier?.name ?? '—',
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.payments_outlined,
            label: 'Payment method',
            value: sale.paymentMethod.toUpperCase(),
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.check_circle_outline,
            label: 'Status',
            value: sale.status,
            valueColor:
                sale.isCompleted ? AppColors.success : AppColors.textPrimary,
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.calculate_outlined,
            label: 'Subtotal',
            value: sale.subtotal.toStringAsFixed(2),
          ),
          const Divider(height: 1),
          DetailRow(
            icon: Icons.receipt_outlined,
            label: 'Total',
            value: sale.total.toStringAsFixed(2),
            valueColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}