import 'package:flutter/material.dart';

class Splash_title extends StatelessWidget {
  const Splash_title({super.key, required this.H, required this.title});

  final double H;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: H * 0.03,
      right: H * 0.03,
      bottom: H * 0.25,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Dela Gothic One', fontSize: 28),
      ),
    );
  }
}
