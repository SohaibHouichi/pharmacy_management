import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/auth/presentation/controllers/auth_controller.dart';
import 'package:pharmacy_management/features/auth/presentation/widgets/header.dart';
import 'package:pharmacy_management/features/auth/presentation/widgets/login_card.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Header(),
                    SizedBox(height: 32),
                    LoginCard(),
                    SizedBox(height: 24),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





