import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final bool showWelcomeCard;
  final VoidCallback onLogin;
  final VoidCallback onCreateAccount;

  const WelcomeCard({
    super.key,
    required this.showWelcomeCard,
    required this.onLogin,
    required this.onCreateAccount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      bottom: showWelcomeCard ? 0 : -300,
      left: 0,
      right: 0,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.brown.withOpacity(0.7),
          borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
        ),
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Where comfort meets certainty in every rental choice.\n"
              "Daleel – helping you find home, hassle-free.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: onLogin,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 55),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onCreateAccount,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 55),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
