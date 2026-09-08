import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';

class GetSaleById {
  final SalesRepository _repository;
  const GetSaleById(this._repository);

  Future<Either<Failure, SaleEntity>> call(int id) =>
      _repository.getSaleById(id);
}
