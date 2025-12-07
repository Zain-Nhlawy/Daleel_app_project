import 'package:flutter/material.dart';
import 'package:daleel_app_project/screen/login_screen.dart';
import 'package:daleel_app_project/screen/signUp_screen.dart';
import 'widgets/animated_logo.dart';
import 'widgets/welcome_card.dart';

class WelcomeCardScreen extends StatefulWidget {
  const WelcomeCardScreen({super.key});

  @override
  State<WelcomeCardScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<WelcomeCardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  bool showWelcomeCard = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scaleAnim = Tween(begin: 0.7, end: 1.9)
    .chain(CurveTween(curve: Curves.easeOut))
    .animate(_controller);

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward().then((_) {
      setState(() {
        showWelcomeCard = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              AnimatedPadding(
                duration: const Duration(milliseconds: 600),
                padding: EdgeInsets.only(top: showWelcomeCard ? 140 : 200),
                child: Center(
                  child: AnimatedLogo(
                    scaleAnim: _scaleAnim,
                    fadeAnim: _fadeAnim,
                  ),
                ),
              ),
              const Spacer(),
              WelcomeCard(
                showWelcomeCard: showWelcomeCard,
                onLogin: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 1),
                    ),
                  );
                },
                onCreateAccount: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const SignUpScreen(),
                      transitionDuration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
