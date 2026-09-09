import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/core.dart';


/// Blocks protected routes when no user is in session.
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final session = Get.find<SessionService>();
    return session.isLoggedIn
        ? null
        : const RouteSettings(name: AppRoute.login);
  }
}

/// Keeps an already-authenticated user off the login page.
class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final session = Get.find<SessionService>();
    return session.isLoggedIn
        ? const RouteSettings(name: AppRoute.dashboard)
        : null;
  }
}