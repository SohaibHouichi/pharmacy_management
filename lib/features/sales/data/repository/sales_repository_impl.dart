import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/data/data_source/sales_remote_data_source.dart';
import 'package:pharmacy_management/features/sales/data/models/mappers/sales_mapper.dart';
import 'package:pharmacy_management/features/sales/data/models/requests/sale_request.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_params.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';

class SalesRepositoryImpl implements SalesRepository {
  final SalesRemoteDataSource _remote;

  SalesRepositoryImpl({required  this._remote});

  @override
  Future<Either<Failure, Paginated<SaleEntity>>> getSales() {
    return guard(() async {
      final response = await _remote.getSales();
      return response.data.toEntities();
    });
  }

  @override
  Future<Either<Failure, SaleEntity>> getSaleById(int id) {
    return guard(() async {
      final response = await _remote.getSaleById(id);
      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, SaleEntity>> createSale(CreateSaleParam param) {
    return guard(() async {
      final response = await _remote.createSale(
        CreateSaleRequest.fromParams(param),
      );
      return response.data.toEntity();
    });
  }
}