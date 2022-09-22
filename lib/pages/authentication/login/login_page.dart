import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/auth%20bloc/app_bloc.dart';
import 'package:shopify_admin/pages/authentication/login/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopifyAuthBloc>(context, listen: true),
      child:const LoginView() ,
    );
  }
}
