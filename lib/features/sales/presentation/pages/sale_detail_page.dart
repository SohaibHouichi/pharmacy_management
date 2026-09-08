import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/widgets/app_state_view.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sale_detail_controller.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/detail/invoice_header.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/detail/items_card.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/detail/summary_card.dart';


class SaleDetailPage extends GetView<SaleDetailController> {
  const SaleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Invoice')),
      body: SafeArea(child: Obx(() => _buildBody())),
    );
  }

  Widget _buildBody() {
    final sale = controller.sale.value;

    if (controller.isLoading.value && sale == null) {
      return const AppLoadingView();
    }

    final error = controller.errorMessage.value;
    if (error != null && sale == null) {
      return AppErrorView(message: error, onRetry: controller.load);
    }

    if (sale == null) {
      return const AppEmptyView(message: 'Invoice not found.');
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: controller.load,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          InvoiceHeader(sale: sale),
          const SizedBox(height: 20),
          ItemsCard(sale: sale),
          const SizedBox(height: 20),
          SummaryCard(sale: sale),
        ],
      ),
    );
  }
}


