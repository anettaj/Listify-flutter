import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Components/ActionButton.dart';
import 'package:todo/Components/Splash_title.dart';
import 'package:todo/Pages/Home.dart';

import '../Components/Splash_container.dart';

class Splash_two extends StatefulWidget {
  const Splash_two({Key? key});

  @override
  State<Splash_two> createState() => _Splash_twoState();
}

class _Splash_twoState extends State<Splash_two> {
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
                  Positioned(
                      bottom: H * 0.46,
                      child: Image.asset('assets/Splash_two.png')),
                  Splash_container(H: H),
                  Splash_title(
                    H: H,
                    title: "Long Press to \nDelete Task",
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route) => false,
            );
          },
          child: Icon(
            Icons.arrow_forward,
            color: Color(0xFFFCFDFF),
          ),
          backgroundColor: Color(0xFFC35959),
        ));
  }
}

