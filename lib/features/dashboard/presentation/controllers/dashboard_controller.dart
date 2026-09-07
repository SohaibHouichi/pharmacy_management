import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/services/session_service.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';
import 'package:pharmacy_management/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:pharmacy_management/features/dashboard/domain/usecase/get_dashborad.dart';

class DashboardController extends GetxController {
  final GetDashboardUsecase getDashboardUseCase;
  final SessionService session;

  DashboardController({
    required this.getDashboardUseCase,
    required this.session,
  });

  final isLoading = false.obs;
  final errorMessage = RxnString();
  final Rxn<DashboardEntity> dashboard = Rxn<DashboardEntity>();

  UserEntity? get user => session.user.value;

  bool get isEmpty =>
      dashboard.value == null && !isLoading.value && errorMessage.value == null;

  @override
  void onInit() async {
    super.onInit();
    await loadDashboard();
  }

  Future<void> loadDashboard() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await getDashboardUseCase();

    isLoading.value = false;
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) => dashboard.value = data,
    );
  }

  Future<void> refreshDashboard() => loadDashboard();

  Future<void> logout() async {
    await session.clear();
    Get.offAllNamed(AppRoute.login);
  }
}
