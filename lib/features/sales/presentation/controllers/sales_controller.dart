import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/usecase/get_sales.dart';

class SalesController extends GetxController {
  final GetSales getSales;

  SalesController({required this.getSales});

  final items = <SaleEntity>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();
  final total = 0.obs;

  bool get isEmpty =>
      items.isEmpty && !isLoading.value && errorMessage.value == null;

  @override
  void onInit() {
    super.onInit();
    loadSales();
  }

  Future<void> loadSales() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await getSales();

    isLoading.value = false;
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (page) {
        items.value = page.items;
        total.value = page.meta.total;
      },
    );
  }

  Future<void> openDetails(int id) async {
    await Get.toNamed(AppRoute.saleDetail, arguments: id);
  }

  Future<void> openNewSale() async {
    final created = await Get.toNamed(AppRoute.saleForm);
    if (created == true) await loadSales();
  }
}