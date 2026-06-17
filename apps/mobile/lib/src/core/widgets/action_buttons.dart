import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/tokens/foundation/dimens.dart';
import '../theme/tokens/foundation/shapes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.leading,
    this.trailing,
    this.expand = false,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: expand ? double.infinity : null,
      height: Dimens.buttonHeight,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.onSurface,
          foregroundColor: theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingItemHorizontal),
          shape: Shapes.button,
        ),
        child: _ActionButtonContent(
          text: text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          leading: leading,
          trailing: trailing,
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.text,
    required this.onPressed,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.leading,
    this.trailing,
    this.expand = false,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final content = _ActionButtonContent(
      text: text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      leading: leading,
      trailing: trailing,
    );

    if (isLight) {
      return SizedBox(
        width: expand ? double.infinity : null,
        height: Dimens.buttonHeight,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: Shapes.button,
          ),
          child: content,
        ),
      );
    }

    return ClipRRect(
      borderRadius: Shapes.buttonRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: Dimens.buttonHeightLarge,
          width: expand ? double.infinity : null,
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: Dimens.opacityGlass),
            borderRadius: Shapes.buttonRadius,
            border: Border.all(
              color: colors.onSurface.withValues(alpha: 0.1),
              width: Dimens.borderThin,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingItemHorizontal),
                  child: content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButtonContent extends StatelessWidget {
  const _ActionButtonContent({
    required this.text,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.leading,
    this.trailing,
  });

  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );

    if (leading == null && trailing == null) return label;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: Dimens.spaceXS),
        ],
        Flexible(child: label),
        if (trailing != null) ...[
          const SizedBox(width: Dimens.spaceXS),
          trailing!,
        ],
      ],
    );
  }
}
