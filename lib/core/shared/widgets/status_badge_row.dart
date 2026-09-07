import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/shared/config/status_style.dart';
import 'package:pharmacy_management/core/shared/widgets/status_badge.dart';

class StatusBadgeRow extends StatelessWidget {
  final List<StatusStyle> styles;
  final bool showIcons;
  final WrapAlignment alignment;

  const StatusBadgeRow({
    super.key,
    required this.styles,
    this.showIcons = false,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    if (styles.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      alignment: alignment,
      children: styles
          .map((s) => StatusBadge(style: s, showIcon: showIcons))
          .toList(),
    );
  }
}