import 'package:daleel_app_project/screen/splash/welcomeCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final player = AudioPlayer();
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeCardScreen()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            
            child: Lottie.asset(
              "assets/lottie/logo.json",
              width: double.infinity,
              height: double.infinity,
              controller: _controller,
              onLoaded: (composition) {
                  player.play(AssetSource("sounds/splashSounds.mp3"));
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
              
            ),
            
          ),
          
        ],
      ),
    );
  }
}
