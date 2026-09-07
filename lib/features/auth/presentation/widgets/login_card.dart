import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/shared/widgets/app_button.dart';
import 'package:pharmacy_management/core/shared/widgets/app_message_banner.dart';
import 'package:pharmacy_management/core/shared/widgets/app_text_field.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/features/auth/presentation/controllers/auth_controller.dart';

class LoginCard extends GetView<AuthController> {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Obx(
        () => Form(
          key: controller.formKey,
          autovalidateMode: controller.autovalidateMode.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() {
                final message = controller.errorMessage.value;
                if (message == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: AppMessageBanner(
                    message: message,
                    onDismiss: controller.clearErrors,
                  ),
                );
              }),

              Obx(
                () => AppTextField(
                  controller: controller.emailCtrl,
                  label: AppConstants.emailLabel,
                  hint: AppConstants.emailHint,
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !controller.isLoading.value,
                  validator: controller.validateEmail,
                  onChanged: (_) => controller.clearFieldError('email'),
                ),
              ),
              const SizedBox(height: 18),

              Obx(
                () => AppTextField(
                  controller: controller.passCtrl,
                  label: AppConstants.passwordLabel,
                  hint: AppConstants.passwordHint,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  enabled: !controller.isLoading.value,
                  validator: controller.validatePassword,
                  onChanged: (_) => controller.clearFieldError('password'),
                  onSubmitted: (_) => controller.submitLogin(),
                ),
              ),

              const SizedBox(height: 14),

              Obx(
                () => AppButton(
                  label: AppConstants.loginButtonText,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.submitLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
