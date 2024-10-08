import 'package:flutter/material.dart';
import 'package:learn_animation_g10/animations/double_animation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DoubleAnimation(),
    );
  }
}
