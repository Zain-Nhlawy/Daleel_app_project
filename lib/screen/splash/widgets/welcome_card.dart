import 'package:daleel_app_project/l10n/app_localizations.dart';
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
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(80)),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.welcome,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.intro,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: onLogin,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              foregroundColor: Colors.white,
              minimumSize: const Size(250, 55),
            ),
            child: Text(
              AppLocalizations.of(context)!.login,
              style: const TextStyle(color: Colors.white, fontSize: 20),
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
            child: Text(
              AppLocalizations.of(context)!.signUp,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
