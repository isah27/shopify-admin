import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/class/model/models.dart';
import 'package:shopify_admin/pages/authentication/login/login_view.dart';
import 'package:shopify_admin/widgets/shopify_widget.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({Key? key}) : super(key: key);

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyProductBloc>(context),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.amber.shade900,
          title: NormalText(
            text: "Categories",
            color: Colors.white,
            size: 30,
          ),
          leading: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                  context.read<ShopifyProductBloc>().add(HomeLoadEvent(value: "category"));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: BlocConsumer<ShopifyProductBloc, ProductStates>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const BlurBackground();
              }
              return SingleChildScrollView(
                child: state is CategoryLoadedState
                    ? Column(
                        children: List.generate(state.category.length, (index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(1),
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  NormalText(
                                      text: state.category[index].name!,
                                      isbBold: true,
                                      size: 30,
                                      color: Colors.amber.shade900
                                          .withOpacity(0.8)),
                                  IconButton(
                                    onPressed: () => context
                                        .read<ShopifyProductBloc>()
                                        .add(DeleteCategoryEvent(
                                            category: state.category[index])),
                                    icon: Icon(Icons.delete_forever,
                                        color: Colors.amber.shade900
                                            .withOpacity(0.8),
                                        size: 35),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.white),
                          ],
                        );
                      }))
                    : Container(),
              );
            },
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red.shade900,
                ));
              }
              if (state is DeletedState || state is UploadedState) {
                context.read<ShopifyProductBloc>().add(FetchCategoryEvent());
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addCategoryDialog(context);
          },
          backgroundColor: Colors.amber.shade900,
          tooltip: "Add new category",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> addCategoryDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          // category text controller
          final controller = TextEditingController();

          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocConsumer<ShopifyProductBloc, ProductStates>(
                      builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return const BlurBackground();
                    }

                    return CustomTextField(
                      enable: state is ProductLoadingState ? false : true,
                      hintText: "category",
                      controller: controller,
                      validator: (String value) =>
                          value.isEmpty ? "This field cannot be empty" : null,
                      icon: Icons.list,
                    );
                  }, listener: (context, state) {
                    if (state is ProductLoadingState) {
                      Stack(children: const [BlurBackground()]);
                    } else if (state is UploadedState) {
                      Navigator.pop(context);
                      controller.clear();
                    }
                  }),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ShopifyProductBloc>().add(
                            UploadCategoryEvent(
                              category: ProductCategory(name: controller.text),
                            ),
                          );
                    }
                  },
                  icon:
                      Icon(Icons.send, color: Colors.amber.shade900, size: 35))
            ],
          );
        });
  }
}
