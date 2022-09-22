import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CatText extends StatelessWidget {
  CatText(
      {Key? key,
      this.color = Colors.black,
      this.size = 30,
      required this.text,
     })
      : super(key: key);
  double size;
  final String text;
  final Color color;
  
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }
}
