import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/class/model/chart_model.dart';
import 'package:shopify_admin/class/model/models.dart';
import 'package:shopify_admin/pages/authentication/login/login_view.dart';
import 'package:shopify_admin/pages/main%20screens/product%20screens/product_category.dart';

import '../../../widgets/shopify_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final currencyFormatter = NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyProductBloc>(context),
      child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: BlocBuilder<ShopifyProductBloc, ProductStates>(
              builder: (context, state) {
            if (state is HomeLoadedState) {
              return Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 45),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: const DecorationImage(
                                  image: AssetImage("assets/ZEK.png"),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            // const CircleAvatar(
                            //   backgroundImage: AssetImage("assets/NZZY.jpg"),
                            // ),
                            NormalText(
                              text: "NAZZY",
                              size: 30,
                              color: Colors.white,
                              isbBold: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<ShopifyProductBloc>()
                                    .add(FetchSalesEvent());
                                 Navigator.pushNamedAndRemoveUntil(context, '/salesdetail', (route) => false);
                                // context
                                //     .read<ShopifyProductBloc>()
                                //     .add(UploadSalesEvent(sales: Sales()));
                              },
                              child: HomeButtonWidget(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    NormalText(
                                        text: " Sales",
                                        size: 50,
                                        isbBold: true),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 80,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          image: DecorationImage(
                                            image:
                                                AssetImage("assets/sales.png"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    NormalText(
                                        text: state.sales.toString(),
                                        size: 50,
                                        isbBold: true),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        return Icon(Icons.star,
                                            color: Colors.amber.shade900);
                                      }),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<ShopifyProductBloc>()
                                    .add(FetchOrderEvent());
                                 Navigator.pushNamedAndRemoveUntil(context, '/orders', (route) => false);
                                // context
                                //     .read<ShopifyProductBloc>()
                                //     .add(UploadOrderEvent(order: Order()));
                              },
                              child: HomeButtonWidget(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    NormalText(
                                        text: "Orders",
                                        size: 50,
                                        isbBold: true),
                                    const SizedBox(height: 10),
                                    NormalText(
                                      text: state.orders.toString(),
                                      size: 50,
                                      isbBold: true,
                                    ),
                                    const SizedBox(height: 5),
                                    Icon(Icons.shopping_cart_sharp,
                                        size: 100, color: Colors.red.shade800),
                                    const SizedBox(height: 2),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<ShopifyProductBloc>()
                                    .add(FetchProductEvent());
                                 Navigator.pushNamedAndRemoveUntil(context, '/productinfo', (route) => false);
                              },
                              child: HomeButtonWidget(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    NormalText(
                                        text: "Products",
                                        size: 45,
                                        isbBold: true),
                                    const SizedBox(height: 5),
                                    Icon(Icons.shopify,
                                        size: 90, color: Colors.red.shade800),
                                    NormalText(
                                        text: state.products.toString(),
                                        size: 50,
                                        isbBold: true),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                 Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false);
                              },
                              child: HomeButtonWidget(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    Icon(Icons.settings,
                                        color: Colors.red.shade800, size: 130),
                                    NormalText(
                                        text: "Settings",
                                        size: 50,
                                        isbBold: true),
                                    const SizedBox(height: 10),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<ShopifyProductBloc>()
                                    .add(FetchCategoryEvent());
                                Navigator.pushNamedAndRemoveUntil(context, '/category', (route) => false);
                              },
                              child: HomeButtonWidget(
                                // height: 150,
                                // width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    FittedBox(
                                      child: NormalText(
                                        text: "Categories",
                                        size: 50,
                                        isbBold: true,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    FittedBox(
                                      child: NormalText(
                                        text: state.categories.toString(),
                                        size: 50,
                                        isbBold: true,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    FittedBox(
                                      child: Icon(Icons.list_alt_rounded,
                                          color: Colors.red.shade900,
                                          size: 100),
                                    ),
                                    const Spacer(),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            HomeButtonWidget(
                              // height: 400,
                              // width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  FittedBox(
                                    child: NormalText(
                                        text: "Total Earning",
                                        size: 60,
                                        isbBold: true),
                                  ),
                                  const SizedBox(height: 10),
                                  FittedBox(
                                    child: NormalText(
                                        text:
                                            "₦${currencyFormatter.format(state.totalEarning)}",
                                        size: 50,
                                        isbBold: true,
                                        color: Colors.amber.shade900),
                                  ),
                                  const SizedBox(height: 5),
                                  FittedBox(
                                    child: Container(
                                        color: Colors.white,
                                        height: 110,
                                        width: 150,
                                        child: LineCharts(
                                          data: [
                                            ChartData(
                                                date: DateTime.parse(
                                                    "2022-09-10"),
                                                earning: 100),
                                            ChartData(
                                                date: DateTime.parse(
                                                    "2022-09-11"),
                                                earning: 20),
                                            ChartData(
                                                date: DateTime.parse(
                                                    "2022-09-13"),
                                                earning: 20),
                                            ChartData(
                                                date: DateTime.parse(
                                                    "2022-09-15"),
                                                earning: 20),
                                            ChartData(
                                                date: DateTime.parse(
                                                    "2022-09-16"),
                                                earning: 20),
                                          ],
                                          width: 400,
                                        )),
                                  ),
                                  // const SizedBox(height: 3),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is ProductLoadingState) {
              return const BlurBackground();
            } else {
              return Center(
                child:
                    state is ErrorState ? NormalText(text: state.error) : null,
              );
            }
          })),
    );
  }
}
