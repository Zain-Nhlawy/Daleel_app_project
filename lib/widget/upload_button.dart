import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const UploadButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.8),
          foregroundColor: Colors.brown,
          side: const BorderSide(color: Colors.white),
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
