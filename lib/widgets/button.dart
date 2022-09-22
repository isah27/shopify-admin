import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   const CustomButton(
      {required this.text,
      required this.onPressed,
      this.withBackground = true,
      this.color=Colors.black,
      this.provideColor=false,
      Key? key})
      : super(key: key);
  final Function? onPressed;
  final String text;
  final bool withBackground;
  final Color color;
  final bool provideColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: withBackground ? provideColor?color: Colors.amber.shade900 : Colors.white,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => onPressed!(),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: withBackground ? Colors.white : Colors.amber.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
