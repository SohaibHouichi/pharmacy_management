import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/config/status_style.dart';
import 'package:pharmacy_management/core/theme/app_fonts.dart';

class StatusBadge extends StatelessWidget {
  final StatusStyle style;
  final bool showIcon;

  const StatusBadge( {super.key, required this.style, this.showIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: style.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(style.icon, size: 12, color: style.color),
            const SizedBox(width: 4),
          ],
          Text(
            style.label,
            style: AppFonts.caption.copyWith(color: style.color),
          ),
        ],
      ),
    );
  }
}