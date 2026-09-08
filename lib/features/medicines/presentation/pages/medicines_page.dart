import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/shared.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/medicines/domain/entity/medicines_entity.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicines_controller.dart';
import 'package:pharmacy_management/features/medicines/presentation/widgets/medicine_search_field.dart';
import 'package:pharmacy_management/features/medicines/presentation/widgets/medicine_tile.dart';

class MedicinesPage extends GetView<MedicinesController> {
  const MedicinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // No Scaffold — MainPage owns it.
    return Column(
      children: [
        _Header(controller: controller),
        Expanded(child: Obx(_buildBody)),
      ],
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value && controller.items.isEmpty) {
      return const AppLoadingView();
    }

    final error = controller.errorMessage.value;
    if (error != null && controller.items.isEmpty) {
      return AppErrorView(message: error, onRetry: controller.loadFirstPage);
    }

    if (controller.isEmpty) {
      return AppEmptyView(
        message: controller.searchQuery.value.isEmpty
            ? AppConstants.emptyMedicinesMessage
            : AppConstants.emptySearchMessage,
        icon: Icons.medication_outlined,
      );
    }

    return PaginatedListView<MedicineEntity>(
      items: controller.items,
      isLoadingMore: controller.isLoadingMore.value,
      hasNextPage: controller.hasNextPage,
      onRefresh: controller.refreshList,
      onLoadMore: controller.loadNextPage,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemBuilder: (_, medicine, _) => MedicineTile(
        medicine: medicine,
        onTap: () => controller.openDetails(medicine.id),
        onEdit: () => controller.openEditForm(medicine),
        onDelete: () => controller.confirmDelete(medicine),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final MedicinesController controller;

  const _Header({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MedicineSearchField(
            key: const ValueKey('medicine-search'),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              controller.total.value == 0
                  ? ''
                  : '${controller.total.value} medicines',
              style: AppFonts.caption,
            ),
          ),
        ],
      ),
    );
  }
}
