import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;              
  final Color? textColor;          
  final bool bordered;            
  final IconData? icon;
  final double borderRadius;
  final EdgeInsets padding;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor,
    this.bordered = false,
    this.icon,
    this.borderRadius = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderWidth = 1.6,
  });

  @override
  Widget build(BuildContext context) {
    return bordered
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: color, width: borderWidth),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(icon, color: textColor ?? color),
                if (icon != null) const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(icon, color: textColor ?? Colors.white),
                if (icon != null) const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}
