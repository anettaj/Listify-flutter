import 'package:flutter/material.dart';
import 'package:todo/Pages/Splash_two.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    required this.Link,
    super.key,
  });
  Widget Link;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Link));
      },
      child: Icon(
        Icons.arrow_forward,
        color: Color(0xFFFCFDFF),
      ),
      backgroundColor: Color(0xFFC35959),
    );
  }
}
