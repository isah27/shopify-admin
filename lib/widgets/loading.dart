import 'package:flutter/material.dart';

import 'normal_text.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.count(
        padding: const EdgeInsets.only(top: 10),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Container(
                  width: 170,
                  height: 120,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.06),

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 35,
                  width: 170,
                  color: Colors.black.withOpacity(0.04),
                  child: FittedBox(
                      child: NormalText(
                    text: "Nike Canvas",
                    size: 25,
                    isbBold: true,
                    color: Colors.black.withOpacity(0.01),
                  )),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.04),

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: SizedBox(
                    height: 10,
                    width: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FittedBox(
                            child: NormalText(
                          text: "NGN:",
                          color: Colors.black.withOpacity(0.04),
                          isbBold: true,
                        )),
                        FittedBox(
                            child: NormalText(
                          text: "10500",
                          color: Colors.black.withOpacity(0.04),
                          isbBold: true,
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
