import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WheelPicker extends StatelessWidget {
  const WheelPicker({
    required this.items,
    required this.initialIndex,
    required this.onItemSelected,
    this.borderRadius,
    this.height = 180,
    super.key,
  });

  final List<String> items;
  final int initialIndex;
  final ValueChanged<int> onItemSelected;
  final BorderRadius? borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 0.8,
        ),
      ),
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        itemExtent: 44,
        onSelectedItemChanged: onItemSelected,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                width: 1.0,
              ),
            ),
          ),
        ),
        children: items.map((item) {
          return Center(
            child: Text(
              item,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
