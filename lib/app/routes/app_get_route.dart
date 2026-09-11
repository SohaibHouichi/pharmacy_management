import 'package:get/get.dart';
import 'package:pharmacy_management/app/middleware/auth_middleware.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/features/shell/shell.dart';
import 'package:pharmacy_management/features/auth/auth.dart';
import 'package:pharmacy_management/features/dashboard/dashboard.dart';
import 'package:pharmacy_management/features/inventory/inventory.dart';
import 'package:pharmacy_management/features/medicines/medicines.dart';
import 'package:pharmacy_management/features/sales/sales.dart';
import 'package:pharmacy_management/features/splash/splash.dart';


abstract class AppGetRoute {
  static List<GetPage<dynamic>> getPages() {
    return [
      GetPage(
        name: AppRoute.splash,
        page: () => const SplashPage(),
        binding: SplashBinding(),
      ),
      GetPage(
        name: AppRoute.login,
        page: () => const LoginPage(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: AppRoute.main,
        page: () => const MainPage(),
        bindings: [
          MainBinding(),
          DashboardBinding(),
          MedicinesBinding(),
          SalesBinding(),
          InventoryBinding()
        ],
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.medicineForm,
        page: () => const MedicineFormPage(),
        binding: MedicineFormBinding(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.medicineDetail,
        page: () => const MedicineDetailPage(),
        binding: MedicineDetailBinding(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.saleForm,
        page: () => const SaleFormPage(),
        binding: SaleFormBinding(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.saleDetail,
        page: () => const SaleDetailPage(),
        binding: SaleDetailBinding(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.inventoryForm,
        page: () => const InventoryFormPage(),
        binding: InventoryFormBinding(),
        middlewares: [AuthMiddleware()],
      ),
    ];
  }
}
