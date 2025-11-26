import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> scaleAnim;
  final Animation<double> fadeAnim;

  const AnimatedLogo({
    super.key,
    required this.scaleAnim,
    required this.fadeAnim,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([scaleAnim, fadeAnim]),
        builder: (_, child) {
          return FadeTransition(
            opacity: fadeAnim,
            child: ScaleTransition(
              scale: scaleAnim,
              child: child,
            ),
          );
        },
        child: Image.asset(
          "assets/images/daleelLogo.png",
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
