import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/constant/app_constants.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.medical_services_outlined,
            color: AppColors.primary,
            size: 34,
          ),
        ),
        const SizedBox(height: 20),
        Text(
         AppConstants.appBrand,
          style: AppFonts.headingLarge.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 6),
        Text(
          AppConstants.loginPageSubtitle,
          style: AppFonts.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}