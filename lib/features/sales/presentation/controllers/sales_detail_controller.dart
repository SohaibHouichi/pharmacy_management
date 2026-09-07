import 'package:get/get.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/usecase/get_sale_by_id.dart';

class SaleDetailController extends GetxController {
  final GetSaleById getSaleById;

  SaleDetailController({required this.getSaleById});

  final Rxn<SaleEntity> sale = Rxn<SaleEntity>();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  late final int saleId;

  @override
  void onInit() {
    super.onInit();
    saleId = Get.arguments as int? ?? 0;
    load();
  }

  Future<void> load() async {
    if (saleId == 0) {
      errorMessage.value = 'Invoice not found.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final result = await getSaleById(saleId);

    isLoading.value = false;
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) => sale.value = data,
    );
  }
}