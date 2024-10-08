import 'dart:developer';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:learn_animation_g10/pages/full_screen_images.dart';

class DoubleAnimation extends StatefulWidget {
  const DoubleAnimation({super.key});

  @override
  State<DoubleAnimation> createState() => _DoubleAnimationState();
}

class _DoubleAnimationState extends State<DoubleAnimation> with TickerProviderStateMixin {
  List<String> images = [
    "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg",
    "https://cdn.pixabay.com/photo/2024/06/20/17/03/fishing-8842590_640.jpg",
    "https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg",
    "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
    "https://pixlr.com/images/index/ai-image-generator-one.webp",
    "https://media.istockphoto.com/id/1317323736/photo/a-view-up-into-the-trees-direction-sky.jpg?s=612x612&w=0&k=20&c=i4HYO7xhao7CkGy7Zc_8XSNX_iqG0vAwNsrH1ERmw2Q=",
    "https://gratisography.com/wp-content/uploads/2024/01/gratisography-covered-in-confetti-800x525.jpg",
    "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
    "https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg",
    "https://c.pxhere.com/photos/16/37/hybridtearosecandella_tamron90mmmacro_sonydslra580_roses_redroses_flowers_aftertherain_publicdomaindedicationcc0-172484.jpg!d"
  ];

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  int cartQuantity = 0;

  // Har bir rasm uchun AnimationController va Animation ob'ektlari
  final List<AnimationController> _pulseControllers = [];
  final List<Animation<double>> _pulseAnimations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < images.length; i++) {
      AnimationController pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
      Animation<double> pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
      );

      _pulseControllers.add(pulseController);
      _pulseAnimations.add(pulseAnimation);
    }
  }

  void startPulseAnimation(int index) {
    _pulseControllers[index].forward().then((_) {
      _pulseControllers[index].reverse();
    });
  }

  @override
  void dispose() {
    for (var controller in _pulseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      dragAnimation: const DragToCartAnimationOptions(rotation: true),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Double Animation'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          actions: [
            AddToCartIcon(
              key: cartKey,
              icon: const Icon(Icons.shopping_cart),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            GlobalKey imageKey = GlobalKey();
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                      imageUrl: images[index],
                      heroTag: 'image_$index',
                    ),
                  ),
                );
              },
              onDoubleTap: () {
                runAddToCartAnimation(imageKey);
                cartKey.currentState!.runCartAnimation((++cartQuantity).toString());
              },
              onLongPress: () {
                log("message");
                startPulseAnimation(index); // Tanlangan rasmni puls animatsiyasini boshlash
              },
              child: AnimatedBuilder(
                animation: _pulseAnimations[index],
                builder: (context, child) {
                  return ScaleTransition(
                    scale: _pulseAnimations[index],
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          key: imageKey,
                          child: Image.network(images[index], fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          itemCount: images.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.save_alt),
        ),
      ),
    );
  }
}
