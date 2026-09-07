import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/network/api_endpoints.dart';
import 'package:pharmacy_management/core/services/session_service.dart';
import 'package:pharmacy_management/core/storage/storage_keys.dart';
import 'package:pharmacy_management/core/storage/storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await StorageService.getSecuredString(StorageKeys.token);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options); // continue middleware chain
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Token expired or revoked mid-session — drop back to login.
    if (err.response?.statusCode == 401) {
      if (Get.isRegistered<SessionService>()) {
        await Get.find<SessionService>().clear();
      } else {
        await StorageService.clearSecuredString();
      }

      if (Get.currentRoute != AppRoute.login &&
          Get.currentRoute != AppRoute.splash) {
        Get.offAllNamed(AppRoute.login);
      }
    }
    return handler.next(err);
  }
}

class ApiClient {
  static Dio? _dio;
  ApiClient._internal();

  static void _setStaticHeaders() {
    _dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static void _setInterceptors() {
    _dio!.interceptors.add(AuthInterceptor());
    _dio!.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );
  }

  static Dio getDio() {
    const Duration timeout = Duration(seconds: 30);
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          // 4xx/5xx must stay DioExceptions so DioExceptionHandler sees them.
          validateStatus: (status) => status != null && status < 400,
        ),
      );
      _dio!
        ..options.connectTimeout = timeout
        ..options.receiveTimeout = timeout;
      _setStaticHeaders();
      _setInterceptors();
    }
    return _dio!;
  }
}