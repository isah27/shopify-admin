import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/auth%20bloc/app_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import 'package:shopify_admin/pages/authentication/signup/signup_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(
        value: BlocProvider.of<ShopifyAuthBloc>(context, listen: true),
      ),
      BlocProvider.value(value: BlocProvider.of<ShopifyProductBloc>(context))
    ], child: const SignUpView());
  }
}
