import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/data/models/requests/sale_request.dart';
import 'package:pharmacy_management/features/sales/data/models/responses/sale_response.dart';

abstract class SalesRemoteDataSource {
  Future<ApiResponse<Paginated<SaleResponse>>> getSales();
  Future<SaleResponse> getSaleById(int id);
  Future<ApiResponse<SaleResponse>> createSale(CreateSaleRequest req);
}

class SalesRemoteDataSourceImpl implements SalesRemoteDataSource {
  final Dio api;
  SalesRemoteDataSourceImpl({required this.api});
  @override
  Future<ApiResponse<SaleResponse>> createSale(CreateSaleRequest req) async {
    try {
      final res = await api.post(ApiEndpoints.sales, data: req.toJson());
      final body = res.data as Map<String, dynamic>;
      if (body['success'] != true || body['data'] == null) {
        throw ValidationException(
          message: body['message'] as String? ?? 'Creation Failed',
          errors: JsonUtils.parseErrors(body['errors']),
        );
      }
      return ApiResponse.fromJson(
        body,
        () => SaleResponse.fromJson(body['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<ApiResponse<Paginated<SaleResponse>>> getSales() async {
    try {
      final res = await api.get(ApiEndpoints.sales);
      final body = res.data as Map<String, dynamic>;
      return ApiResponse.fromJson(body, () {
        final items =
            (body['data'] as List?)
                ?.whereType<Map<String, dynamic>>()
                .map(SaleResponse.fromJson)
                .toList() ??
            const <SaleResponse>[];

        final rawMeta = body['meta'];
        return Paginated<SaleResponse>(
          items: items,
          meta: PaginationMeta.fromJson(rawMeta),
        );
      });
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  @override
  Future<SaleResponse> getSaleById(int id) async {
    try {
      final res = await api.get('${ApiEndpoints.sales}/$id');
      final body = res.data['data'];
      return SaleResponse.fromJson(body);
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }
}
