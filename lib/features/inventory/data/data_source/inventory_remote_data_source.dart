import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/inventory/data/models/requests/inventory_request.dart';
import 'package:pharmacy_management/features/inventory/data/models/responses/inventory_alerts_response.dart';
import 'package:pharmacy_management/features/inventory/data/models/responses/inventory_updated_response.dart';

abstract class InventoryRemoteDataSource {
  Future<ApiResponse<InventoryAlertsResponse>> getInventory();
  Future<ApiResponse<InventoryUpdatedResponse>> updateInventory(
    InventoryRequest req,
  );
}

class InventoryRemoteDataSourceImpl implements InventoryRemoteDataSource {
  final Dio api;
  InventoryRemoteDataSourceImpl({required this.api});

  @override
  Future<ApiResponse<InventoryAlertsResponse>> getInventory() async {
    try {
      final res = await api.get(ApiEndpoints.inventoryAlerts);
      final body = res.data as Map<String, dynamic>;

      _ensureSuccess(body, 'Could not load inventory alerts');

      return ApiResponse.fromJson(
        body,
        () => InventoryAlertsResponse.fromJson(
          body['data'] as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<ApiResponse<InventoryUpdatedResponse>> updateInventory(
    InventoryRequest req,
  ) async {
    try {
      final res = await api.post(
        ApiEndpoints.inventoryStock,
        data: req.toJson(),
      );
      final body = res.data as Map<String, dynamic>;

      _ensureSuccess(body, 'Could not update stock');

      return ApiResponse.fromJson(
        body,
        () => InventoryUpdatedResponse.fromJson(
          body['data'] as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  void _ensureSuccess(Map<String, dynamic> body, String fallback) {
    if (body['success'] != true || body['data'] == null) {
      throw ValidationException(
        message: body['message'] as String? ?? fallback,
        errors: JsonUtils.parseErrors(body['errors']),
      );
    }
  }
}