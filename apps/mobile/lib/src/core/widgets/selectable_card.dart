import 'package:flutter/material.dart';
import '../theme/tokens/foundation/dimens.dart';

class SelectableCard extends StatelessWidget {
  const SelectableCard({
    required this.selected,
    required this.onClick,
    required this.child,
    this.borderRadius,
    this.padding,
    super.key,
  });

  final bool selected;
  final VoidCallback onClick;
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final borderColor = selected
        ? colors.primary
        : colors.outline.withValues(alpha: 0.3);

    final borderWidth = selected
        ? Dimens.borderThick
        : Dimens.borderThin;

    final containerColor = selected
        ? colors.primary.withValues(alpha: 0.1)
        : colors.onSurface.withValues(alpha: 0.05);

    final resolvedBorderRadius = borderRadius ?? BorderRadius.circular(Dimens.radiusCard);

    return Card(
      elevation: Dimens.elevationNone,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: resolvedBorderRadius),
      child: InkWell(
        onTap: onClick,
        borderRadius: resolvedBorderRadius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: resolvedBorderRadius,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          padding: padding ?? const EdgeInsets.all(Dimens.paddingCard),
          child: child,
        ),
      ),
    );
  }
}
