import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../widget/custom_text_field.dart';
import 'package:daleel_app_project/screen/login_screen.dart';

class SignUpPage2 extends StatelessWidget {
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController location;
  final VoidCallback pickLocation;
  final Future<bool> Function() signUp;

  const SignUpPage2({
    super.key,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.location,
    required this.pickLocation,
    required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.7),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.createAccount,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 28),
            CustomTextField(
              controller: phone,
              label: AppLocalizations.of(context)!.phoneNumber,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: location,
              label: AppLocalizations.of(context)!.location,
              icon: Icons.location_on,
              readOnly: true,
              onTap: pickLocation,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: password,
              label: AppLocalizations.of(context)!.password,
              icon: Icons.lock,
              keyboardType: TextInputType.text,
              obscure: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: confirmPassword,
              label: AppLocalizations.of(context)!.confirmPassword,
              icon: Icons.lock,
              keyboardType: TextInputType.text,
              obscure: true,
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 180,
                height: 55,
                child: OutlinedButton(
                  onPressed: () async {
                    bool success = await signUp();
                    
                    if (success && context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, anim1, anim2) => const LoginScreen(),
                          transitionDuration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(AppLocalizations.of(context)!.signUp, style: const TextStyle(fontSize: 20)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.alreadyHaveAnAccount,
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, anim1, anim2) =>
                            const LoginScreen(),
                        transitionDuration: const Duration(milliseconds: 600),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
