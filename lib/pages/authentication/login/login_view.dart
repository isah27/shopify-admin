import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/product%20data%20bloc/product_bloc.dart';
import '../../../class/bloc/auth bloc/app_bloc.dart';
import '../../../class/validator/auth_validator.dart';
import '../../../widgets/shopify_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final AuthValidator _validator = AuthValidator();
  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<ShopifyAuthBloc, ShopifyAuthState>(
            listener: (context, state) {
          if (state is AuthenticatedState) {
            context.read<ShopifyProductBloc>().add(HomeLoadEvent(value: ""));
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is ErrorsState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade900,
                content: Text(state.error),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }, builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 350,
                  child: CurveContainer(),
                ),
                Positioned(
                  top: 370,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Email(
                                  emailController: emailController,
                                  validator: _validator),
                              const SizedBox(height: 8),
                              Password(
                                  passwordController: passwordController,
                                  validator: _validator),
                              const SizedBox(height: 5),
                              // Error Text
                              NormalText(
                                  text: state is ErrorsState ? state.error : "",
                                  size: 12,
                                  color: Colors.red),
                              const SizedBox(height: 35),
                              LoginButton(
                                  formKey: _formKey,
                                  emailController: emailController,
                                  passwordController: passwordController),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have an account?",
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.amber.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Blur
                state is LoadingState ? const BlurBackground() : Container(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CurveContainer extends StatelessWidget {
  const CurveContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 50, right: 50, top: 100, bottom: 100),
      decoration: BoxDecoration(
        color: Colors.amber.shade900,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: FittedBox(
        child: Text(
          "SHOPIFY",
          style: TextStyle(
              color: Colors.white,
              fontSize: 100,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              shadows: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(5, 4), // changes position of shadow
                ),
              ]),
        ),
      ),
    );
  }
}

class BlurBackground extends StatelessWidget {
  const BlurBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: Center(
              child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.amber.shade900))),
        ))
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: "Login",
        onPressed: () {
          _formKey.currentState!.validate();
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            BlocProvider.of<ShopifyAuthBloc>(context).add(
              LoginEvent(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              ),
            );
          }
        });
  }
}

class Password extends StatelessWidget {
  const Password({
    Key? key,
    required this.passwordController,
    required AuthValidator validator,
  })  : _validator = validator,
        super(key: key);

  final TextEditingController passwordController;
  final AuthValidator _validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "Password",
      isObscure: true,
      controller: passwordController,
      validator: (value) => _validator.passwordValidation(
        value,
        isConfirm: false,
      ),
      icon: Icons.lock,
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    Key? key,
    required this.emailController,
    required AuthValidator validator,
  })  : _validator = validator,
        super(key: key);

  final TextEditingController emailController;
  final AuthValidator _validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "Email",
      controller: emailController,
      validator: (value) => _validator.emailValidation(value),
      icon: Icons.email,
    );
  }
}
