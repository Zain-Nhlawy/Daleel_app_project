import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:daleel_app_project/screen/login_screen.dart';
import 'package:daleel_app_project/screen/signUp_screen.dart'; 
import 'widgets/animated_logo.dart';
import 'widgets/welcome_card.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _rotateAnim;
  late Animation<double> _fadeAnim;

  bool showWelcomeCard = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _scaleAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.2, end: 1.1).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.1, end: 1.1).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _rotateAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 50 * math.pi / 180).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 50 * math.pi / 180, end: 0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

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
                padding: EdgeInsets.only(top: showWelcomeCard ? 50 : 150),
                child: Center(
                  child: AnimatedLogo(
                    scaleAnim: _scaleAnim,
                    rotateAnim: _rotateAnim,
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
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
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
