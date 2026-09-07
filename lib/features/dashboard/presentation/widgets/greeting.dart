
import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class Greeting extends StatelessWidget {
  final String? name;
  const Greeting({this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back,', style: AppFonts.bodyMuted),
        const SizedBox(height: 2),
        Text(name ?? 'Pharmacist', style: AppFonts.headingMedium),
      ],
    );
  }
}
