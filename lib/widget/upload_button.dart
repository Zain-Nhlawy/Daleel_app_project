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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isUploaded ? Colors.lightGreen : Colors.transparent,
                border: Border.all(color: Colors.brown),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isUploaded ? Icons.check : Icons.add,
                  size: 20,
                  color: isUploaded ? Colors.white : Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
