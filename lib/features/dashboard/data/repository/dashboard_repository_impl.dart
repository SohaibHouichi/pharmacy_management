import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/core/error/guard.dart';
import 'package:pharmacy_management/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:pharmacy_management/features/dashboard/data/models/mappers/dashboard_mapper.dart';
import 'package:pharmacy_management/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:pharmacy_management/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remote;

  DashboardRepositoryImpl({required this._remote});


  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() {
    return guard(() async {
      final response = await _remote.getDashboard();
      return response.data.toEntity();
    });
  }
}