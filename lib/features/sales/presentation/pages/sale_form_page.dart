import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/core.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/cart_list.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/sale_form_footer.dart';
import 'package:pharmacy_management/features/sales/presentation/widgets/form/sale_search_section.dart';

class SaleFormPage extends StatelessWidget {
  const SaleFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pushed above the shell, so it owns its own Scaffold.
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('New sale')),
      body: const SafeArea(
        child: Column(
          children: [
            SaleSearchSection(),
            Expanded(child: CartList()),
            SaleFormFooter(),
          ],
        ),
      ),
    );
  }
}
