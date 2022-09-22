import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/widgets/shopify_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyProductBloc>(context),
      child: Scaffold(
        backgroundColor: Colors.amber.shade900.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.amber.shade900,
          title: NormalText(
            text: "Settings",
            color: Colors.white,
            size: 30,
          ),
          leading: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                  context.read<ShopifyProductBloc>().add(HomeLoadEvent(value: "setting"));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
        ),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print("update");
                },
                child: HomeButtonWidget(
                  color: Colors.amber.withOpacity(0.4),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Spacer(),
                      Icon(Icons.edit_note_rounded,
                          color: Colors.red.shade900, size: 100),
                      const Spacer(),
                      NormalText(
                          text: "Update Information",
                          isbBold: true,
                          size: 45,
                          color: Colors.red.shade900),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  print("delete");
                },
                child: HomeButtonWidget(
                  color: Colors.amber.withOpacity(0.4),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Spacer(),
                      Icon(Icons.delete_forever,
                          color: Colors.red.shade900, size: 100),
                      const Spacer(),
                      NormalText(
                        text: "Delete Account",
                        isbBold: true,
                        size: 45,
                        color: Colors.red.shade900,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
