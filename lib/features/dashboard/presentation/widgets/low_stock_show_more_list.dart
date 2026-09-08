import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/dashboard/presentation/widgets/low_stock_tile.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';

class LowStockShowMoreList extends StatelessWidget {
  final List<MedicineEntity> medicines;
  const LowStockShowMoreList({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ListTile.divideTiles(
        context: context,
        color: AppColors.divider,
        tiles: medicines.map((m) => LowStockTile(medicine: m)),
      ).toList(),
    );
  }
}