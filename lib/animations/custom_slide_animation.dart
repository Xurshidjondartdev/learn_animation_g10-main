import 'package:flutter/material.dart';

class CustomSlideAnimation extends StatefulWidget {
  const CustomSlideAnimation({super.key});

  @override
  State<CustomSlideAnimation> createState() => _CustomSlideAnimationState();
}

class _CustomSlideAnimationState extends State<CustomSlideAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(1, -2),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    super.initState();
  }

  void _play() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Slide Animation"),
      ),

      //body
      body: Center(
          child: SlideTransition(
        position: _animation,
        child: const FlutterLogo(
          size: 100,
        ),
      )),

      // play
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
