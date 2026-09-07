import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/shared/widgets/app_state_view.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sales_controller.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/sale_tile.dart';

class SalesPage extends GetView<SalesController> {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                controller.total.value == 0
                    ? ''
                    : '${controller.total.value} invoices',
                style: AppFonts.caption,
              ),
            ),
          ),
        ),
        Expanded(child: Obx(() => _buildBody())),
      ],
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value && controller.items.isEmpty) {
      return const AppLoadingView();
    }

    final error = controller.errorMessage.value;
    if (error != null && controller.items.isEmpty) {
      return AppErrorView(message: error, onRetry: controller.loadSales);
    }

    if (controller.isEmpty) {
      return const AppEmptyView(
        message: AppConstants.emptySalesMessage,
        icon: Icons.receipt_long_outlined,
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: controller.loadSales,
      child: ListView.separated(
        // Bottom padding clears the FAB.
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final sale = controller.items[i];
          return SaleTile(
            sale: sale,
            onTap: () => controller.openDetails(sale.id),
          );
        },
      ),
    );
  }
}