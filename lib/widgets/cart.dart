import 'package:flutter/material.dart';
// import '../pages/main_screens/cart_page.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);
  //final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        child: Container(
          height: 60,
          color: Colors.amber.shade900,
          child: IconButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
            color: Colors.white,
          ),
        ),
      ),
      Positioned(
        right: 6,
        top: 10,
        width: 13,
        child: Container(
          decoration:const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Text(
            "1",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.amber.shade900, fontSize: 15),
          ),
        ),
      )
    ]);
  }
}
