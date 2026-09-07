import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/features/sales/data/data_source/sales_remote_data_source.dart';
import 'package:pharmacy_management/features/sales/data/repository/sales_repository_impl.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';
import 'package:pharmacy_management/features/sales/domain/usecase/get_sales.dart';
import 'package:pharmacy_management/features/sales/presentation/controllers/sales_controller.dart';

class SalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesRemoteDataSource>(
      () => SalesRemoteDataSourceImpl(api: Get.find<Dio>()),
      fenix: true,
    );
    Get.lazyPut<SalesRepository>(
      () => SalesRepositoryImpl(remote: Get.find<SalesRemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut<GetSales>(
      () => GetSales(Get.find<SalesRepository>()),
      fenix: true,
    );
    Get.put<SalesController>(
      SalesController(getSales: Get.find<GetSales>()),
    );
  }
}