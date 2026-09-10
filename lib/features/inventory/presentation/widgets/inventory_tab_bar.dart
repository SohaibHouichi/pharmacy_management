import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/presentation/controllers/inventory_controller.dart';

class InventoryTabBar extends GetView<InventoryController> {
  const InventoryTabBar({super.key});

  StatusStyle _styleFor(InventoryTab tab) => switch (tab) {
        InventoryTab.all => StatusConfig.inStock,
        InventoryTab.lowStock => StatusConfig.lowStock,
        InventoryTab.expiringSoon => StatusConfig.expiringSoon,
        InventoryTab.expired => StatusConfig.expired,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Obx(
        () => Row(
          children: InventoryTab.values.map((tab) {
            final isActive = controller.selectedTab.value == tab;
            final style = _styleFor(tab);
            final count = controller.countFor(tab);

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () => controller.changeTab(tab),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isActive ? style.surface : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive ? style.color : AppColors.border,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          style.icon,
                          size: 18,
                          color: isActive
                              ? style.color
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$count',
                          style: AppFonts.titleMedium.copyWith(
                            color: isActive
                                ? style.color
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          style.label,
                          style: AppFonts.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}