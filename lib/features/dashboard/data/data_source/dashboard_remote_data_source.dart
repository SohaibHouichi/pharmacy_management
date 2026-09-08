import 'package:dio/dio.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/dashboard/data/models/responses/dashboard_response.dart';

abstract class DashboardRemoteDataSource {
  Future<ApiResponse<DashboardResponse>> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio api;
  DashboardRemoteDataSourceImpl({required this.api});

  @override
  Future<ApiResponse<DashboardResponse>> getDashboard() async {
    try {
      final res = await api.get(ApiEndpoints.dashboard);
      final body = res.data as Map<String, dynamic>;
      return ApiResponse.fromJson(
        body,
        () => DashboardResponse.fromJson(body['data'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }
}
