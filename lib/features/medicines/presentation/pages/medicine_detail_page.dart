import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/shared/widgets/app_state_view.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/medicines/presentation/controllers/medicine_detail_controller.dart';
import 'package:pharmacy_management/features/medicines/presentation/widgets/detail/header_card.dart';
import 'package:pharmacy_management/features/medicines/presentation/widgets/detail/info_card.dart';

class MedicineDetailPage extends GetView<MedicinesDetailController> {
  const MedicineDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pushed above the shell, so it owns its own Scaffold.
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Medicine details')),
      body: SafeArea(child: Obx(() => _buildBody())),
    );
  }

  Widget _buildBody() {
    final medicine = controller.medicine.value;

    // Only blank the screen when there's nothing to show yet.
    if (controller.isLoading.value && medicine == null) {
      return const AppLoadingView();
    }

    final error = controller.errorMessage.value;
    if (error != null && medicine == null) {
      return AppErrorView(message: error, onRetry: controller.load);
    }

    if (medicine == null) {
      return const AppEmptyView(message: 'Medicine not found.');
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: controller.load,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          HeaderCard(medicine: medicine),
          const SizedBox(height: 20),
          InfoCard(medicine: medicine),
        ],
      ),
    );
  }
}

