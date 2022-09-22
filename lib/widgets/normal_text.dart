// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  NormalText({
    Key? key,
    this.size = 30,
    this.color = Colors.black54,
    this.isbBold = false,
    required this.text,
  }) : super(key: key);
  double size;
  final String text;
  final Color color;
  bool isbBold;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isbBold ? FontWeight.bold : FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      softWrap: true,
    );
  }
}
