import 'package:flutter/material.dart';

class Splash_container extends StatelessWidget {
  const Splash_container({
    super.key,
    required this.H,
  });

  final double H;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                1.0,
                6.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            )
          ],
          color: Color(0xFFFCFDFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50))),
      height: H / 2,
    );
  }
}
