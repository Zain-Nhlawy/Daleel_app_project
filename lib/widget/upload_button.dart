import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isUploaded;

  const UploadButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isUploaded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
          foregroundColor: theme.colorScheme.primary,
          side: BorderSide(color: theme.colorScheme.onSurface),
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isUploaded
                    ? theme.colorScheme.secondary
                    : Colors.transparent,
                border: Border.all(color: theme.colorScheme.primary),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isUploaded ? Icons.check : Icons.add,
                  size: 20,
                  color: isUploaded
                      ? theme.colorScheme.onSecondary
                      : theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
