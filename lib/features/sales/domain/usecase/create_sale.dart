import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_entity.dart';
import 'package:pharmacy_management/features/sales/domain/entity/sale_param.dart';
import 'package:pharmacy_management/features/sales/domain/repository/sales_repository.dart';

class CreateSale {
  final SalesRepository _repository;
  const CreateSale(this._repository);

  Future<Either<Failure, SaleEntity>> call(CreateSaleParam param) =>
      _repository.createSale(param);
}