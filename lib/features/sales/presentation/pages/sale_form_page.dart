import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/widgets/app_button.dart';
import 'package:pharmacy_management/core/shared/widgets/app_message_banner.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sales_form_controller.dart';

class SaleFormPage extends GetView<SaleFormController> {
  const SaleFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('New sale')),
      body: SafeArea(
        child: Column(
          children: [
            _SearchSection(),
            Expanded(child: Obx(() => _buildCart())),
            Obx(() => _buildFooter()),
          ],
        ),
      ),
    );
  }

  Widget _buildCart() {
    if (controller.cart.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 48,
                color: AppColors.textHint,
              ),
              const SizedBox(height: 16),
              Text(
                'Search for a medicine to start the sale.',
                style: AppFonts.bodyMuted,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: controller.cart.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _CartLineTile(index: i),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.errorMessage.value != null) ...[
            AppMessageBanner(
              message: controller.errorMessage.value!,
              onDismiss: () => controller.errorMessage.value = null,
            ),
            const SizedBox(height: 14),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Estimated total', style: AppFonts.bodyMuted),
              Text(
                controller.estimatedTotal.toStringAsFixed(2),
                style: AppFonts.headingMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const SizedBox(height: 14),
          AppButton(
            label: 'Complete sale (cash)',
            isLoading: controller.isSaving.value,
            onPressed: controller.canSubmit ? controller.submit : null,
          ),
        ],
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  _SearchSection();
  final _controller = Get.find<SaleFormController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        children: [
          TextField(
            controller: _controller.searchController,
            onChanged: _controller.searchMedicines,
            style: AppFonts.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Search a medicine to add…',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: AppColors.surface,
              suffixIcon: Obx(
                () => _controller.isSearching.value
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          Obx(() {
            if (_controller.searchResults.isEmpty) {
              return const SizedBox.shrink();
            }
            return Container(
              margin: const EdgeInsets.only(top: 6),
              constraints: const BoxConstraints(maxHeight: 220),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _controller.searchResults.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final medicine = _controller.searchResults[i];
                  final outOfStock = medicine.quantity == 0;

                  return ListTile(
                    dense: true,
                    enabled: !outOfStock,
                    title: Text(medicine.name, style: AppFonts.bodyMedium),
                    subtitle: Text(
                      outOfStock
                          ? 'Out of stock'
                          : 'Stock ${medicine.quantity} · '
                                '${medicine.price.toStringAsFixed(2)}',
                      style: AppFonts.caption.copyWith(
                        color: outOfStock ? AppColors.error : null,
                      ),
                    ),
                    trailing: const Icon(Icons.add, size: 18),
                    onTap: outOfStock
                        ? null
                        : () => _controller.addToCart(medicine),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CartLineTile extends StatelessWidget {
  final int index;
  const _CartLineTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SaleFormController>();
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
              _QtyButton(
                icon: Icons.remove,
                onTap: () =>
                    controller.changeQuantity(index, line.quantity - 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('${line.quantity}', style: AppFonts.titleMedium),
              ),
              _QtyButton(
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

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
