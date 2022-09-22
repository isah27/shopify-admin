import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({
    Key? key,
    this.height = 250,
    this.width = 180,
    this.color = Colors.amber,
    required this.child,
  }) : super(key: key);
  final double height;
  final double width;
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}
