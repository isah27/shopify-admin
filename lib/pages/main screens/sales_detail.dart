import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/pages/authentication/login/login_view.dart';
import 'package:shopify_admin/widgets/shopify_widget.dart';
import 'package:intl/intl.dart';

class SalesDetail extends StatefulWidget {
  const SalesDetail({Key? key}) : super(key: key);

  @override
  State<SalesDetail> createState() => _SalesDetailState();
}

class _SalesDetailState extends State<SalesDetail> {
  final currencyFormatter = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyProductBloc>(context, listen: true),
      child: Scaffold(
        appBar: AppBar(
            title: NormalText(text: "Sales", size: 40, color: Colors.white),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                  context.read<ShopifyProductBloc>().add(HomeLoadEvent(value: "sales"));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: Colors.amber.shade900),
        body: BlocConsumer<ShopifyProductBloc, ProductStates>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const BlurBackground();
            }
            return state is SalesLoadedState
                ? SingleChildScrollView(
                    child: Column(
                      children: List.generate(state.sales.length, (index) {
                        return Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage("assets/ZEK.png")),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  children: [
                                    NormalText(text: state.sales[index].name!),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(
                                              5,
                                              (starIndex) => Icon(
                                                    Icons.star,
                                                    color: state.sales[index]
                                                                .rating! >
                                                            starIndex
                                                        ? Colors.amber.shade900
                                                        : Colors.black12,
                                                    size: 10,
                                                  )),
                                        ),
                                        const SizedBox(width: 3),
                                        NormalText(
                                            text: '25-oct-2021', size: 12),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                FittedBox(
                                    child: NormalText(
                                        text:
                                            '₦${currencyFormatter.format(state.sales[index].price)}',
                                        size: 20))
                              ],
                            ));
                      }),
                    ),
                  )
                : Container(color: Colors.transparent);
          },
          listener: ((context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red.shade900,
              ));
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber.shade900,
          tooltip: 'Clear sales history',
          child: const Icon(Icons.clear_outlined),
        ),
      ),
    );
  }
}
