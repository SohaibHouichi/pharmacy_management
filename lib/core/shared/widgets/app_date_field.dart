import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final String hint;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final String? errorText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool enabled;

  const AppDateField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    this.errorText,
    this.firstDate,
    this.lastDate,
    this.enabled = true,
  });

  String get _display {
    final date = value;
    if (date == null) return hint;
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final first = firstDate ?? DateTime(now.year - 20);
    final last = lastDate ?? DateTime(now.year + 20);

    // The stored value may predate `first`, so clamp before opening.
    var initial = value ?? today.add(const Duration(days: 365));
    if (initial.isBefore(first)) initial = first;
    if (initial.isAfter(last)) initial = last;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.label),
        const SizedBox(height: 6),
        InkWell(
          onTap: enabled ? () => _pick(context) : null,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            decoration: BoxDecoration(
              color: enabled ? AppColors.surface : AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: hasError ? AppColors.error : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _display,
                    style: AppFonts.bodyLarge.copyWith(
                      color: hasValue
                          ? AppColors.textPrimary
                          : AppColors.textHint,
                    ),
                  ),
                ),
                if (hasValue)
                  const Icon(
                    Icons.edit_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
              ],
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(errorText!, style: AppFonts.error),
          ),
      ],
    );
  }
}
