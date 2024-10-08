import 'package:flutter/material.dart';

class CustomBouncingAnimation extends StatefulWidget {
  const CustomBouncingAnimation({super.key});

  @override
  State<CustomBouncingAnimation> createState() => _CustomBouncingAnimationState();
}

class _CustomBouncingAnimationState extends State<CustomBouncingAnimation> with TickerProviderStateMixin{


  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween<double>(
      begin: 600,
      end: 0
    ).animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.0, 1.0, curve: Curves.easeInCubic),));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat(reverse: true);
      }
    });



    super.initState();
  }

  void _play(){
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
        title: const Text("Bouncing Animation"),
      ),

      //body
      body: Align(
        alignment: const Alignment(0, 0.75),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (builder, child){
            return Padding(
              padding: EdgeInsets.only(bottom: _animation.value),
              child: const Icon(Icons.sports_volleyball, size: 80,),
            );
          },
        )
      ),

      // play
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
