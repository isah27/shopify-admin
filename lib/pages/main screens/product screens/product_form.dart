import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../class/bloc/product data bloc/product_bloc.dart';
import '../../../class/model/models.dart';
import '../../../class/validator/product_validator.dart';
import '../../../widgets/shopify_widget.dart';
import '../../authentication/login/login_view.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  XFile? image;

  final currencyFormatter = NumberFormat("#,##0.00", "en_US");

  final _formkey = GlobalKey<FormState>();
  // creating instance of product validator
  final validator = ProductValidator();
  // form controllers
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _description = TextEditingController();
  // creating Product model instance
  // ignore: prefer_final_fields
  Product _product = Product();
  // creating variable to hold category value
  String category = "Wears";
  // text box enable status
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<ShopifyProductBloc>().add(FetchProductEvent());
            Navigator.pushNamedAndRemoveUntil(
                context, '/productinfo', (route) => false);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: NormalText(text: "Product form", size: 30, color: Colors.white),
        backgroundColor: Colors.amber.shade900,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocConsumer<ShopifyProductBloc, ProductStates>(
                    builder: (context, state) {
                  if (state is ProductUpdatingState) {
                    _product = state.product;
                    assignUpdateProductToTextField(updating: true);
                  }
                  if (state is UpdatedState) {
                    assignUpdateProductToTextField(updating: false);
                  }
                  return const Text("");
                }, listener: (context, state) {
                  if (state is ProductUpdatingState) {
                    setState(() {
                      BlocConsumer<ShopifyProductBloc, ProductStates>(
                        builder: (context, state) {
                          if (state is ProductLoadingState) {
                            return const BlurBackground();
                          }
                          if (state is ProductUpdatingState) {
                            _product = state.product;
                            assignUpdateProductToTextField(updating: true);
                          }
                          if (state is UpdatedState) {
                            assignUpdateProductToTextField(updating: false);
                          }
                          if (state is ImageLoadedState) {
                            image = state.image;
                          }
                          return const Text("");
                        },
                        listener: (context, state) {
                          if (state is ProductUpdatingState) {
                          }
                          if (state is UpdatedState) {
                            ClearFields().clearTextField(controllers: [
                              _description,
                              _priceController,
                              _nameController
                            ]);
                          }

                          if (state is UploadedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.amber.shade900,
                                content: NormalText(
                                    text: "Product Added Successfully",
                                    color: Colors.white,
                                    size: 20),
                              ),
                            );

                            ClearFields().clearTextField(controllers: [
                              _description,
                              _priceController,
                              _nameController
                            ]);
                          } else if (state is ErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: NormalText(
                                    text: state.error,
                                    color: Colors.white,
                                    size: 20),
                              ),
                            );
                          }
                          if (state is ImageLoadedState) {
                            image = state.image;
                          }
                        },
                      );
                    });
                  }
                }),
                CustomTextField(
                  hintText: "Product Name",
                  controller: _nameController,
                  validator: (value) => validator.name(value),
                  allowIcon: false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: "Product Price",
                  controller: _priceController,
                  validator: (value) => validator.price(value),
                  allowIcon: false,
                ),
                const SizedBox(height: 20),
                AppDropdownInput(
                  options: const ["Wears", "Food", "Electronic gadget"],
                  value: category,
                  getLabel: (value) => value as String,
                  onChanged: (value) => setState(() {
                    category = value as String;
                  }),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: "Product Description",
                  controller: _description,
                  validator: (value) => validator.description(value),
                  allowIcon: false,
                ),
                const SizedBox(height: 20),
                BlocBuilder<ShopifyProductBloc, ProductStates>(
                    builder: (context, state) {
                  ImageLoadedState? img;
                  Future.delayed(Duration.zero, () {
                    img = state as ImageLoadedState;
                  });

                  return Column(
                    children: [
                      Visibility(
                        visible: state is ProductLoadingState ? false : true,
                        child: CustomButton(
                          withBackground: false,
                          text: "Pick your product image",
                          onPressed: state is ProductUpdatingState ||
                                  state is ProductLoadingState
                              ? null
                              : () => context
                                  .read<ShopifyProductBloc>()
                                  .add(PickImageEvent()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      state is ProductLoadingState
                          ? Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade900,
                                  shape: BoxShape.circle),
                              child: const CircularProgressIndicator.adaptive(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : CustomButton(
                              text: state is ProductUpdatingState
                                  ? "Update Product"
                                  : "Upload Product",
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  if (state is ImageLoadedState ||
                                      state is ProductUpdatingState) {
                                    context.read<ShopifyProductBloc>().add(
                                        state is ProductUpdatingState
                                            ? UpdateProductEvent(
                                                product: product(_product))
                                            : UploadProductEvent(
                                                product: product(_product),
                                                image: img!.image));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please select at least one image for you product",
                                        backgroundColor: Colors.red.shade900,
                                        textColor: Colors.white);
                                  }
                                }
                              }),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void assignUpdateProductToTextField({required bool updating}) {
    Future.delayed(Duration.zero, () {
      _nameController.text = updating ? _product.name! : "";
      _priceController.text = updating ? _product.price!.toString() : "";
      _description.text = updating ? _product.description! : "";
      category = updating ? _product.category! : "";
    });
  }

  Product product(Product product) {
    product.name = _nameController.text;
    product.price = int.parse(_priceController.text);
    product.description = _description.text;
    product.category = category;
    return _product;
  }
}
