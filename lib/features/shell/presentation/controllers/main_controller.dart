import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/auth/auth.dart';

enum MainTab { dashboard, medicines, sales, inventory }

class MainController extends GetxController {
  final LogoutUseCase logoutUseCase;
  final SessionService session;

  MainController({required this.logoutUseCase, required this.session});

  final currentIndex = 0.obs;
  final isLoggingOut = false.obs;

  MainTab get currentTab => MainTab.values[currentIndex.value];
  UserEntity? get user => session.user.value;

  String get title => switch (currentTab) {
        MainTab.dashboard => AppConstants.dashboardLable,
        MainTab.medicines => AppConstants.medicinesLable,
        MainTab.sales => AppConstants.salesLable,
        MainTab.inventory => AppConstants.inventoryLable,
      };

  /// First letter of the user's name, for the avatar.
  String get initial {
    final name = user?.name.trim() ?? '';
    return name.isEmpty ? '?' : name[0].toUpperCase();
  }

  void changeTab(int index) {
    if (index != currentIndex.value) currentIndex.value = index;
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    await logoutUseCase();
    await session.clear();
    isLoggingOut.value = false;

    Get.offAllNamed(AppRoute.login);
  }
}