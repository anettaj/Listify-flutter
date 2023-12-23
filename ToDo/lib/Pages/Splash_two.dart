import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Components/ActionButton.dart';
import 'package:todo/Components/Splash_title.dart';
import 'package:todo/Pages/Home.dart';

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
