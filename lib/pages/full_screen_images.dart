import 'package:flutter/material.dart';
import 'dart:ui';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const FullScreenImage({super.key, required this.imageUrl, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Orqa fon uchun blur effekt
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Glasmorphism effektini yaratish uchun BackdropFilter va Container
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Orqa fonni blur qiladi
              child: Container(
                color: Colors.black.withOpacity(0.3), // Qisman shaffof qora fon
              ),
            ),
          ),
          // Qahramon rasm uchun GestureDetector
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);  // Ekranga tegish orqali orqaga qaytish
              },
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),  // Burchaklarni yumaloq qilish
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
