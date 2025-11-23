import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> scaleAnim;
  final Animation<double> rotateAnim;
  final Animation<double> fadeAnim;

  const AnimatedLogo({
    super.key,
    required this.scaleAnim,
    required this.rotateAnim,
    required this.fadeAnim,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: scaleAnim,
        builder: (_, child) {
          return Transform.rotate(
            angle: rotateAnim.value,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              scale: scaleAnim.value,
              child: Opacity(
                opacity: fadeAnim.value,
                child: child,
              ),
            ),
          );
        },
        child: Image.asset(
          "assets/images/logo.png",
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
