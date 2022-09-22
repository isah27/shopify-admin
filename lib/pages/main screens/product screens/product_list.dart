import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../widgets/shopify_widget.dart';
import '../../authentication/login/login_view.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({Key? key}) : super(key: key);

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  final currencyFormatter = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyProductBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade900,
          title: NormalText(text: "Products", color: Colors.white),
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
                context
                    .read<ShopifyProductBloc>()
                    .add(HomeLoadEvent(value: "products"));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Container(
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: BlocConsumer<ShopifyProductBloc, ProductStates>(
              builder: (context, state) {
            if (state is ProductLoadingState) {
              return const BlurBackground();
            } else if (state is ProductLoadedState) {
              final product = state.product;
              return SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(product.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/detailpage');
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  product[index].image!)),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    const SizedBox(width: 5),
                                    FittedBox(
                                      child: Column(
                                        children: [
                                          // product name
                                          NormalText(
                                            text: product[index].name!,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                          const SizedBox(width: 3),
                                          // date
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: NormalText(
                                                text:
                                                    "${product[index].description}",
                                                size: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ShopifyProductBloc>()
                                                  .add(
                                                      ProductUpdatingProductEvent(
                                                          product:
                                                              product[index]));

                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/productform',
                                                  (route) => false);
                                            },
                                            icon: Icon(Icons.edit_note_outlined,
                                                size: 48,
                                                color: Colors.blue.shade900)),
                                        const SizedBox(height: 2),
                                        IconButton(
                                            onPressed: () => context
                                                .read<ShopifyProductBloc>()
                                                .add(DeleteProductEvent(
                                                    product: product[index])),
                                            icon: Icon(Icons.delete_forever,
                                                size: 45,
                                                color: Colors.red.shade900)),
                                      ],
                                    ),
                                    const Spacer(),
                                    // price and quantity of the order
                                    SizedBox(
                                      width: 70,
                                      child: FittedBox(
                                          child: NormalText(
                                        text:
                                            '₦${currencyFormatter.format(product[index].price)}',
                                        size: 20,
                                        color: Colors.amber.shade900,
                                        isbBold: true,
                                      )),
                                    )
                                  ],
                                ),
                                const Divider(),
                              ],
                            )),
                      );
                    }),
                  ),
                ),
              );
            } else {
              return const BlurBackground();
            }
          }, listener: (context, state) {
            if (state is ProductUpdatingState) {}
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red.shade900,
              ));
            }

            if (state is DeletedState) {
              context.read<ShopifyProductBloc>().add(FetchProductEvent());
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/productform', (route) => false);
            // addProductDialog(context);
          },
          backgroundColor: Colors.amber.shade900,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
