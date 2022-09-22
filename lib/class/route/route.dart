import 'package:flutter/material.dart';
import 'package:shopify_admin/pages/authentication/login/login_page.dart';
import 'package:shopify_admin/pages/authentication/signup/signup_view.dart';
import 'package:shopify_admin/pages/main%20screens/order%20pages/order_detail_page.dart';
import 'package:shopify_admin/pages/main%20screens/homePage/home_view.dart';
import 'package:shopify_admin/pages/main%20screens/order%20pages/order_page.dart';
import 'package:shopify_admin/pages/main%20screens/product%20screens/product_category.dart';
import 'package:shopify_admin/pages/main%20screens/product%20screens/product_form.dart';
import 'package:shopify_admin/pages/main%20screens/product%20screens/product_list.dart';
import 'package:shopify_admin/pages/main%20screens/sales_detail.dart';
import 'package:shopify_admin/pages/main%20screens/setting.dart';

class AppRoute {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case "/signup":
        return MaterialPageRoute(builder: (_) => const SignUpView());

      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeView());

      case "/salesdetail":
        return MaterialPageRoute(builder: (_) => const SalesDetail());

      case "/orders":
        return MaterialPageRoute(builder: (_) => const OrderPage());

      case "/productinfo":
        return MaterialPageRoute(builder: (_) => const ProductInfoPage());

      case "/productform":
        return MaterialPageRoute(builder: (_) => const ProductForm());

      case "/category":
        return MaterialPageRoute(builder: (_) => const ProductCategories());

      case "/detailpage":
        return MaterialPageRoute(builder: (_) => const DetailPage());

      case "/settings":
        return MaterialPageRoute(builder: (_) => const SettingPage());
      default:
        return MaterialPageRoute(builder: (_) => const WrongPageRouteId());
    }
  }
}

class WrongPageRouteId extends StatelessWidget {
  const WrongPageRouteId({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red.shade900,
      child: const Center(
        child: Text(
          "Whooop! \n Something went wrong\nCheck your route id",
          style:
              TextStyle(decoration: TextDecoration.none, color: Colors.white),
        ),
      ),
    );
  }
}
