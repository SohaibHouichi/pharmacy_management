import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/low_stock_show_more_button.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/low_stock_show_more_list.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class LowStockSection extends StatelessWidget {
  final DashboardEntity data;
  const LowStockSection({super.key, required this.data});

  static const int previewCount = 3;
  bool get _hasMore => data.lowStockMedicines.length > previewCount;
  List<MedicineEntity> get _preview => _hasMore
      ? data.lowStockMedicines.take(previewCount).toList()
      : data.lowStockMedicines;

  void _showAll() {
    AppBottomSheet.show(
      title: 'Low stock medicines',
      subtitle: '${data.lowStockMedicines.length} items below minimum',
      child: LowStockShowMoreList(medicines: data.lowStockMedicines),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Low stock medicines', style: AppFonts.titleMedium),
            if (data.hasLowStock)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.errorSurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${data.lowStockCount}',
                  style: AppFonts.caption.copyWith(color: AppColors.error),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: data.lowStockMedicines.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28),
                  child: AppEmptyView(
                    message: 'All medicines are sufficiently stocked.',
                    icon: Icons.check_circle_outline,
                  ),
                )
              : Column(
                  children: [
                    LowStockShowMoreList(medicines: _preview),
                    if (_hasMore) ...[
                      const Divider(height: 1),
                      LowStockShowMoreButton(
                        remaining: (data.lowStockMedicines.length - previewCount).toInt(),
                        onTap: _showAll,
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}
