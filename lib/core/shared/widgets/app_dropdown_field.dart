import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

/// Same API shape as before, but the popup is drawn by us — so it matches
/// the field's width, radius and border exactly.
class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<({T value, String label})> options;
  final ValueChanged<T?> onChanged;
  final IconData? prefixIcon;
  final String? errorText;
  final bool enabled;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.options,
    required this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.enabled = true,
  });

  String get _display {
    for (final option in options) {
      if (option.value == value) return option.label;
    }
    return hint;
  }

  Future<void> _openMenu(BuildContext fieldContext) async {
    final box = fieldContext.findRenderObject() as RenderBox?;
    final overlay =
        Overlay.of(fieldContext).context.findRenderObject() as RenderBox?;
    if (box == null || overlay == null) return;

    final origin = box.localToGlobal(Offset.zero, ancestor: overlay);
    final width = box.size.width;

    final picked = await showMenu<T>(
      context: fieldContext,
      // Locking min and max to the field's width is what keeps them equal.
      constraints: BoxConstraints(
        minWidth: width,
        maxWidth: width,
        maxHeight: 320,
      ),
      position: RelativeRect.fromLTRB(
        origin.dx,
        origin.dy + box.size.height + 6,
        overlay.size.width - origin.dx - width,
        0,
      ),
      color: AppColors.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      // The menu draws its own padding; ours would double it.
      menuPadding: const EdgeInsets.symmetric(vertical: 6),
      items: [
        for (final option in options)
          PopupMenuItem<T>(
            value: option.value,
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _MenuRow(
              label: option.label,
              selected: option.value == value,
            ),
          ),
      ],
    );

    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final hasError = errorText != null;
    final isTappable = enabled && options.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.label),
        const SizedBox(height: 6),

        // Builder gives us a context whose RenderBox is the field itself.
        Builder(
          builder: (fieldContext) => InkWell(
            onTap: isTappable ? () => _openMenu(fieldContext) : null,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: enabled ? AppColors.surface : AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: hasError ? AppColors.error : AppColors.border,
                ),
              ),
              child: Row(
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon, size: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      _display,
                      style: AppFonts.bodyLarge.copyWith(
                        // A chosen value reads as confirmed; the hint stays muted.
                        color: hasValue
                            ? AppColors.primary
                            : AppColors.textHint,
                        fontWeight: hasValue ? AppFonts.medium : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (hasValue) ...[
                    const Icon(Icons.check, size: 18, color: AppColors.primary),
                    const SizedBox(width: 8),
                  ],
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: isTappable
                        ? AppColors.textSecondary
                        : AppColors.disabled,
                  ),
                ],
              ),
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

class _MenuRow extends StatelessWidget {
  final String label;
  final bool selected;

  const _MenuRow({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppFonts.bodyLarge.copyWith(
              color: selected ? AppColors.primary : AppColors.textPrimary,
              fontWeight: selected ? AppFonts.medium : null,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (selected)
          const Icon(Icons.check, size: 18, color: AppColors.primary),
      ],
    );
  }
}
