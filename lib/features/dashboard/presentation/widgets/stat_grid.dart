import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/stat_card.dart';

class StatsGrid extends StatelessWidget {
  final DashboardEntity data;
  const StatsGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Two columns on phones, three when there's room.
        final columns = constraints.maxWidth > 620 ? 3 : 2;
        const spacing = 12.0;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        final cards = [
          StatCard(
            label: 'Total medicines',
            value: '${data.totalMedicines}',
            icon: Icons.medication_outlined,
          ),
          StatCard(
            label: 'Low stock',
            value: '${data.lowStockCount}',
            icon: Icons.warning_amber_outlined,
            color: AppColors.warning,
            surface: AppColors.warningSurface,
          ),
          StatCard(
            label: "Today's sales",
            value: '${data.todaySales.count}',
            icon: Icons.receipt_long_outlined,
            color: AppColors.info,
            surface: AppColors.infoSurface,
          ),
          StatCard(
            label: "Today's revenue",
            value: data.todaySales.total.toStringAsFixed(2),
            icon: Icons.payments_outlined,
            color: AppColors.success,
            surface: AppColors.successSurface,
          ),
        ];

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards
              .map((card) => SizedBox(width: width, child: card))
              .toList(),
        );
      },
    );
  }
}