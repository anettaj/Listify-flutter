import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Components/ActionButton.dart';
import 'package:todo/Components/Splash_title.dart';
import 'package:todo/Pages/Splash_two.dart';

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
                Container(
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
                ),
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
