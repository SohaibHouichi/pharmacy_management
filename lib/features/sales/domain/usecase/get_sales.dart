import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/domain/paginated.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';

class GetSales {
  final SalesRepository _repository;
  const GetSales(this._repository);

  Future<Either<Failure, Paginated<SaleEntity>>> call() =>
      _repository.getSales();
}