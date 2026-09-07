import 'package:get/get.dart';
import 'package:pharmacy_management/app/middleware/auth_middleware.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/shared/main/presentation/bindings/main_binding.dart';
import 'package:pharmacy_management/core/shared/main/presentation/pages/main_page.dart';
import 'package:pharmacy_management/features/auth/presentation/bindings/auth_binding.dart';
import 'package:pharmacy_management/features/auth/presentation/pages/auth_page.dart';
import 'package:pharmacy_management/features/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:pharmacy_management/features/medicines/presentation/bindings/medicine_detail_binding.dart';
import 'package:pharmacy_management/features/medicines/presentation/bindings/medicine_form_binding.dart';
import 'package:pharmacy_management/features/medicines/presentation/bindings/medicines_binding.dart';
import 'package:pharmacy_management/features/medicines/presentation/pages/medicine_detail_page.dart';
import 'package:pharmacy_management/features/medicines/presentation/pages/medicine_form_page.dart';
import 'package:pharmacy_management/features/sales/presentation/bindings/sales_binding.dart';
import 'package:pharmacy_management/features/sales/presentation/bindings/sales_detail_binding.dart';
import 'package:pharmacy_management/features/sales/presentation/bindings/sales_form_binding.dart';
import 'package:pharmacy_management/features/sales/presentation/pages/sale_detail_page.dart';
import 'package:pharmacy_management/features/sales/presentation/pages/sale_form_page.dart';
import 'package:pharmacy_management/features/splash/presentation/bindings/splash_binding.dart';
import 'package:pharmacy_management/features/splash/presentation/pages/splash_page.dart';

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
        bindings: [MainBinding(), DashboardBinding(), MedicinesBinding(), SalesBinding()],
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.medicineForm,
        page: () => const MedicineFormPage(),
        binding: MedicineFormBinding(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: AppRoute.medicinesDetails,
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
    ];
  }
}
