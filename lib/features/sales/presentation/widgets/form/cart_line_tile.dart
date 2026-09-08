import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sale_form_controller.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/qty_button.dart';

class CartLineTile extends GetView<SaleFormController> {
  final int index;

  const CartLineTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final line = controller.cart[index];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: line.exceedsStock ? AppColors.error : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.medicine.name,
                      style: AppFonts.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${line.medicine.price.toStringAsFixed(2)} each · '
                      'stock ${line.medicine.quantity}',
                      style: AppFonts.caption,
                    ),
                  ],
                ),
              ),
              Text(
                line.total.toStringAsFixed(2),
                style: AppFonts.titleMedium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              QtyButton(
                icon: Icons.remove,
                onTap: () =>
                    controller.changeQuantity(index, line.quantity - 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('${line.quantity}', style: AppFonts.titleMedium),
              ),
              QtyButton(
                icon: Icons.add,
                onTap: () =>
                    controller.changeQuantity(index, line.quantity + 1),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: AppColors.error,
                ),
                onPressed: () => controller.removeLine(index),
              ),
            ],
          ),
          if (line.exceedsStock)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Only ${line.medicine.quantity} in stock',
                style: AppFonts.error,
              ),
            ),
        ],
      ),
    );
  }
}