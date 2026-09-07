import 'package:dartz/dartz.dart';
import 'package:pharmacy_management/core/error/failures.dart';
import 'package:pharmacy_management/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:pharmacy_management/features/dashboard/domain/repository/dashboard_repository.dart';

class GetDashboardUsecase {
  final DashboardRepository _dashboardRepository;
  GetDashboardUsecase({required this._dashboardRepository});

  Future<Either<Failure, DashboardEntity>> call() async {
    return await _dashboardRepository.getDashboard();
  }
}
