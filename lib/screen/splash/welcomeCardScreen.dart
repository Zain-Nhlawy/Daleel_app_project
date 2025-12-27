import 'package:flutter/material.dart';
import 'package:daleel_app_project/screen/login_screen.dart';
import 'package:daleel_app_project/screen/signup_screen.dart';
import 'widgets/animated_logo.dart';
import 'widgets/welcome_card.dart';

class WelcomeCardScreen extends StatefulWidget {
  const WelcomeCardScreen({super.key});

  @override
  State<WelcomeCardScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<WelcomeCardScreen>
    with SingleTickerProviderStateMixin {
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

    _scaleAnim = Tween(
      begin: 0.7,
      end: 1.9,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // theme-aware background
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Background.jpg",
              fit: BoxFit.cover,
              color: theme.brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.3)
                  : null, // optional dark overlay
              colorBlendMode: BlendMode.darken,
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            top: showWelcomeCard ? 170 : 250,
            left: 0,
            right: 0,
            child: AnimatedLogo(scaleAnim: _scaleAnim, fadeAnim: _fadeAnim),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            bottom: showWelcomeCard ? 0 : -400,
            left: 0,
            right: 0,
            child: WelcomeCard(
              showWelcomeCard: showWelcomeCard,
              onLogin: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginScreen(),
                    transitionDuration: const Duration(seconds: 1),
                  ),
                );
              },
              onCreateAccount: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SignUpScreen(),
                    transitionDuration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
