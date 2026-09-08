import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_params.dart';

abstract class SalesRepository {
  Future<Either<Failure, Paginated<SaleEntity>>> getSales();
  Future<Either<Failure, SaleEntity>> getSaleById(int id);
  Future<Either<Failure, SaleEntity>> createSale(CreateSaleParam req);
}
