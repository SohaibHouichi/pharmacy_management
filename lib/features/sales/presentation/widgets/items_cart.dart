
import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/item_row.dart';

class ItemsCard extends StatelessWidget {
  final SaleEntity sale;
  const ItemsCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text('Items (${sale.itemCount})', style: AppFonts.titleMedium),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: ListTile.divideTiles(
              context: context,
              color: AppColors.divider,
              tiles: sale.items.map((item) => ItemRow(item: item)),
            ).toList(),
          ),
        ),
      ],
    );
  }
}