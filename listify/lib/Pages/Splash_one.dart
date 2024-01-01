import 'package:flutter/material.dart';
import 'package:listify/Components/ActionButton.dart';
import 'package:listify/Components/Splash_title.dart';
import 'package:listify/Pages/Splash_two.dart';

import '../Components/Splash_container.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFC35959),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Splash_container(H: H),
                Positioned(
                    bottom: H * 0.35,
                    child: Image.asset('assets/Splash_one.png')),
                Splash_title(
                  H: H,
                  title: "Organize Your Day \nwith Listify",
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ActionButton(
        Link: Splash_two(),
      ),
    );
  }
}
