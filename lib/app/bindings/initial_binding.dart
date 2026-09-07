import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/network/api_client.dart';
import 'package:pharmacy_management/core/services/session_service.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SessionService>(SessionService(), permanent: true);
    // Core networking client — used by ALL remote data sources
    Get.put<Dio>(ApiClient.getDio(), permanent: true);

  }
}