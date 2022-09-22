import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/class/repository/auth%20repository/auth_repo.dart';
import 'package:shopify_admin/class/repository/product%20repository/product_repo.dart';
import 'class/bloc/auth bloc/app_bloc.dart';
import 'class/route/route.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppRoute appRoute = AppRoute();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShopifyAuthBloc(UserRepository())),
        BlocProvider(create: (_) => ShopifyProductBloc(ProductRepository())),
      ],
      child: MaterialApp(
        title: 'Shopify Admin',
        theme: ThemeData(
            // This is the theme of your application.
            // primarySwatch: Colors.amber,
            ),
        onGenerateRoute: appRoute.onGeneratedRoute,
      ),
    );
  }
}
