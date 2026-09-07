import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/app/bindings/initial_binding.dart';
import 'package:pharmacy_management/app/routes/app_get_route.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/theme/app_theme.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.light,
      initialRoute: AppRoute.splash,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
      getPages: AppGetRoute.getPages()
    );
  }
}
