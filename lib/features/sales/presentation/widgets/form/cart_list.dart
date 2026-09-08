import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sale_form_controller.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/cart_line_tile.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/empty_cart_view.dart';

class CartList extends GetView<SaleFormController> {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.cart.isEmpty && controller.searchResults.isEmpty) return const EmptyCartView();

      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: controller.cart.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) => CartLineTile(index: i),
      );
    });
  }
}