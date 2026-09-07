import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/app/routes/app_route.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/services/session_service.dart';
import 'package:pharmacy_management/core/utils/form_error_mixin.dart';
import 'package:pharmacy_management/core/utils/validators.dart';
import 'package:pharmacy_management/features/auth/data/model/requests/auth_request.dart';
import 'package:pharmacy_management/features/auth/domain/usecase/login.dart';
import 'package:pharmacy_management/features/auth/domain/usecase/logout.dart';

class AuthController extends GetxController with FormErrorsMixin {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final SessionService session;

  AuthController({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.session,
  });

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final isLoading = false.obs;

  late final validateEmail = validator('email', [
    Validators.required(AppConstants.emailLabel),
    Validators.email(),
  ]);

  late final validatePassword = validator('password', [
    Validators.required(AppConstants.passwordLabel),
    Validators.minLength(6, AppConstants.passwordLabel),
  ]);

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }

  Future<void> submitLogin() async {
    if (!validateForm()) return;

    isLoading.value = true;
    final result = await loginUseCase(
      AuthRequest(email: emailCtrl.text.trim(), password: passCtrl.text),
    );
    isLoading.value = false;

    result.fold(handleFailure, (auth) {
      session.setUser(auth.user);
      emailCtrl.clear();
      passCtrl.clear();
      resetForm();
      Get.offAllNamed(AppRoute.main);
    });
  }

  Future<void> logout() async {
    isLoading.value = true;
    await logoutUseCase();
    isLoading.value = false;
    await session.clear();
    emailCtrl.clear();
    passCtrl.clear();
    resetForm();
    Get.offAllNamed(AppRoute.login);
  }
}