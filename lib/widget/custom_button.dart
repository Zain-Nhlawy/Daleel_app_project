import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color; // optional, can use theme if null
  final Color? textColor; // optional
  final bool bordered;
  final IconData? icon;
  final double borderRadius;
  final EdgeInsets padding;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.bordered = false,
    this.icon,
    this.borderRadius = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderWidth = 1.6,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color buttonColor = color ?? theme.colorScheme.primary;
    final Color foregroundColor =
        textColor ?? (bordered ? buttonColor : theme.colorScheme.onPrimary);

    return bordered
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: buttonColor, width: borderWidth),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
              foregroundColor: foregroundColor,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, color: foregroundColor),
                if (icon != null) const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, color: foregroundColor),
                if (icon != null) const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}
