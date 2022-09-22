import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/widgets/shopify_widget.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final currencyFormatter = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyProductBloc>(context),
      child: Scaffold(
        appBar: AppBar(
            title: NormalText(
                text: "Orders", size: 40, isbBold: true, color: Colors.white),
                leading: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                  context.read<ShopifyProductBloc>().add(HomeLoadEvent(value: "orders"));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: Colors.amber.shade900),
        body: SingleChildScrollView(
            child: BlocConsumer<ShopifyProductBloc, ProductStates>(
                builder: (context, state) {
          return state is OrderLoadedState
              ? Column(
                  children: List.generate(state.order.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detailpage');
                      },
                      child: Container(
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
                                  // product name
                                  NormalText(
                                      text: state.order[index].productName!),
                                  const SizedBox(width: 3),
                                  // date
                                  NormalText(text: '25-oct-2021', size: 12),
                                ],
                              ),
                              const Spacer(),
                              // price and quantity of the order
                              FittedBox(
                                  child: NormalText(
                                      text:
                                          '₦${currencyFormatter.format(state.order[index].price)} (${state.order[index].quantity})',
                                      size: 20))
                            ],
                          )),
                    );
                  }),
                )
              : Container();
        }, listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red.shade900,
            ));
          }
        })),
      ),
    );
  }
}
