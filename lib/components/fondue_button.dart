import 'package:flutter/material.dart';

enum FondueButtonVariant { primary, secondary, tertiary }

class FondueButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final FondueButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  const FondueButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = FondueButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color textColor;

    switch (variant) {
      case FondueButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        textColor = Colors.white;
        break;
      case FondueButtonVariant.secondary:
        backgroundColor = Colors.transparent;
        textColor = theme.colorScheme.primary;
        break;
      case FondueButtonVariant.tertiary:
        backgroundColor = Colors.transparent;
        textColor = theme.colorScheme.secondary;
        break;
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              variant == FondueButtonVariant.secondary
                  ? BorderSide(color: theme.colorScheme.primary)
                  : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          else ...[
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(text),
          ],
        ],
      ),
    );
  }
}
