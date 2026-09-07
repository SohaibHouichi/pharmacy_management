import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final IconData? prefixIcon;
  final String? errorText;
  final bool enabled;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.enabled = true,
  });

  /// Builds a themed menu item, so call sites don't repeat the text style.
  static DropdownMenuItem<T> item<T>({
    required T value,
    required String label,
  }) {
    return DropdownMenuItem<T>(
      value: value,
      child: Text(
        label,
        style: AppFonts.bodyLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.label),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          isExpanded: true,
          style: AppFonts.bodyLarge,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: enabled ? AppColors.textSecondary : AppColors.disabled,
          ),
          // The popup itself isn't covered by inputDecorationTheme.
          dropdownColor: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          elevation: 2,
          menuMaxHeight: 320,
          hint: Text(
            hint,
            style: AppFonts.bodyLarge.copyWith(color: AppColors.textHint),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          disabledHint: Text(
            hint,
            style: AppFonts.bodyLarge.copyWith(color: AppColors.textHint),
          ),
          decoration: InputDecoration(
            errorText: errorText,
            filled: true,
            fillColor: enabled ? AppColors.surface : AppColors.surfaceMuted,
            errorStyle: AppFonts.error,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
            border: _border(AppColors.border),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary, width: 1.6),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error, width: 1.6),
            disabledBorder: _border(AppColors.border),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}