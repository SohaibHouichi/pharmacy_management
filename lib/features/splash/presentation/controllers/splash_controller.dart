import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/auth/auth.dart';

class SplashController extends GetxController {
  final GetCurrentUser getCurrentUserUseCase;
  final SessionService session;

  SplashController({
    required this.getCurrentUserUseCase,
    required this.session,
  });

  @override
  void onReady() {
    _decideStartRoute();
    super.onReady();
  }

  Future<void> _decideStartRoute() async {
    final hasToken = await session.hasToken();

    if (!hasToken) {
      Get.offAllNamed(AppRoute.login);
      return;
    }

    final result = await getCurrentUserUseCase();
    await result.fold(
      (failure) async {
        await session.clear();
        Get.offAllNamed(AppRoute.login);
      },
      (user) async {
        session.setUser(user);
        Get.offAllNamed(AppRoute.main);
      },
    );
  }
}
