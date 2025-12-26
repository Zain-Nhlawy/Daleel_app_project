import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/screen/splash/welcomeCardScreen.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final player = AudioPlayer();
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _handleNavigation();
      }
    });
  }

  void _handleNavigation() async {
    if (!mounted) return;

    if (pendingNotificationMessage != null) {
      final message = pendingNotificationMessage!;
      pendingNotificationMessage = null;

      final type = message.data['type'];
      if (type == 'rate_department') {
        final departmentIdStr = message.data['department_id'];
        if (departmentIdStr == null) return;
        final departmentId = int.tryParse(departmentIdStr);
        if (departmentId == null) return;

        final apartments2 = await apartmentController.fetchApartment(
          departmentId,
        );
        if (apartments2 == null) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeScreenTabs()),
          (route) => false,
        );

        Future.delayed(const Duration(milliseconds: 200), () {
          if (navigatorKey.currentState != null) {
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (_) => ApartmentDetailsScreen(
                  apartment: apartments2,
                  withRate: true,
                ),
              ),
            );
          }
        });
        return;
      }
    }

    if (userController.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreenTabs()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WelcomeCardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
