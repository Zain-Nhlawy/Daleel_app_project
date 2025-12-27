import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? borderColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.readOnly = false,
    this.onTap,
    this.borderColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color finalBorderColor =
        widget.borderColor ?? theme.colorScheme.primary.withOpacity(0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textDirection: Directionality.of(context),
          obscureText: widget.obscure ? _hide : false,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 16,
            ),
            filled: true,
            fillColor: theme.colorScheme.surface.withOpacity(0.8),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),

            prefixIcon: widget.icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8),
                      Icon(widget.icon, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Container(
                        width: 1,
                        height: 24,
                        color: theme.colorScheme.primary.withOpacity(0.5),
                      ),
                      const SizedBox(width: 8),
                    ],
                  )
                : null,

            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(
                      _hide ? Icons.visibility_off : Icons.visibility,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _hide = !_hide;
                      });
                    },
                  )
                : null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: finalBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: finalBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
