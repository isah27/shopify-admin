import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify_admin/class/bloc/auth%20bloc/app_bloc.dart';
import 'package:shopify_admin/class/model/models.dart';
import 'package:shopify_admin/pages/authentication/login/login_view.dart';

import '../../../class/validator/auth_validator.dart';
import '../../../widgets/shopify_widget.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  //form key
  final _formKey = GlobalKey<FormState>();
  String gender = "Male";
  String acctType = "Saving";
  // calling validator class
  AuthValidator validator = AuthValidator();
  // editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final acctNameController = TextEditingController();
  final acctNumberController = TextEditingController();
  // creating user model instance
  static Users users = Users();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.amber.shade900,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Colors.amber.shade900,
                Colors.black.withOpacity(0.2),
              ],
              stops: const [
                0.4,
                0.9,
              ]),
        ),
        child: Stack(
          children: [
            // navigate back icon button
            const NavigateToLogin(),
            // Text
            Positioned(
              top: 50,
              right: 30,
              left: 30,
              //bottom: 0,
              child: Center(
                child: NormalText(
                  text: "Create new account",
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            // form
            Positioned(
              top: 80,
              left: 5,
              right: 5,
              bottom: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FullName(
                            nameController: nameController,
                            validator: validator),
                        const SizedBox(height: 15),
                        Email(
                            emailController: emailController,
                            validator: validator),
                        const SizedBox(height: 15),
                        MobiliNumber(
                            phoneNumberController: phoneNumberController,
                            validator: validator),
                        const SizedBox(height: 15),
                        HomeAddress(
                            addressController: addressController,
                            validator: validator),
                        const SizedBox(height: 15),
                        // gender
                        AppDropdownInput(
                          hintText: "Gender",
                          options: const ["Male", "Female"],
                          value: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value!;
                            });
                            ;
                          },
                          getLabel: (String value) => value,
                        ),
                        const SizedBox(height: 15),
                        BankName(
                            bankNameController: bankNameController,
                            validator: validator),
                        const SizedBox(height: 15),
                        AccountName(
                            acctNameController: acctNameController,
                            validator: validator),
                        const SizedBox(height: 15),
                        AccountNumber(
                            acctNumberController: acctNumberController,
                            validator: validator),
                        const SizedBox(height: 15),
                        // account types e.g (saving/current)
                        AppDropdownInput(
                          hintText: "Account Type",
                          options: const ["Saving", "Current"],
                          value: acctType,
                          onChanged: (String? value) {
                            setState(() {
                              acctType = value!;
                            });
                          },
                          getLabel: (String value) => value,
                        ),
                        const SizedBox(height: 15),
                        Password(
                            passwordController: passwordController,
                            validator: validator),
                        const SizedBox(height: 15),
                        ConfirmPasword(
                            confirmPasswordController:
                                confirmPasswordController,
                            validator: validator,
                            passwordController: passwordController),
                        const SizedBox(height: 15),
                        const SizedBox(height: 5),
                        BlocConsumer<ShopifyAuthBloc, ShopifyAuthState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              Stack(
                                children: const [BlurBackground()],
                              );
                            }
                            // Error Text
                            return NormalText(
                                text: state is ErrorsState ? state.error : "",
                                size: 12,
                                color: Colors.red);
                          },
                          listener: (context, state) {
                            if (state is ErrorsState) {
                            } else if (state is SignedUpState) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/", (route) => false);
                            }
                          },
                        ),
                        // Sign Up Button
                        CustomButton(
                            text: "Register",
                            onPressed: () {
                              final formState = _formKey.currentState;
                              if (formState!.validate()) {
                                formState.save();
                                context
                                    .read<ShopifyAuthBloc>()
                                    .add(SignUpEvent(users: _users(users)));
                              }
                              print(acctType);
                            }),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // button that redirect to login if you've already sign up
            Positioned(
              bottom: 7,
              left: 5,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NormalText(
                    text: "Already have an account?",
                    // color: ,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: (() {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }),
                    child: NormalText(
                      text: "Login",
                      size: 18,
                      isbBold: true,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Users _users(Users users) {
    users.username = nameController.text;
    users.email = emailController.text;
    users.phoneNumber = phoneNumberController.text;
    users.gender = gender;
    users.address = addressController.text;
    users.bankNames = bankNameController.text;
    users.accountNames = acctNameController.text;
    users.accountNumbers = acctNumberController.text;
    users.accountTypes = acctType;
    users.password = passwordController.text;
    return users;
  }
}

class AccountNumber extends StatelessWidget {
  const AccountNumber({
    Key? key,
    required this.acctNumberController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController acctNumberController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Account Number",
        controller: acctNumberController,
        validator: (value) => validator.emptyValidator(value),
        icon: Icons.filter_3_sharp);
  }
}

class AccountName extends StatelessWidget {
  const AccountName({
    Key? key,
    required this.acctNameController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController acctNameController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Account Name",
        controller: acctNameController,
        validator: (value) => validator.emptyValidator(value),
        icon: Icons.account_box_outlined);
  }
}

class BankName extends StatelessWidget {
  const BankName({
    Key? key,
    required this.bankNameController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController bankNameController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Bank(e.g. zenith) without adding 'Bank'",
        controller: bankNameController,
        validator: (value) => validator.emptyValidator(value),
        icon: Icons.account_balance_outlined);
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: "Register",
        onPressed: () {
          // print();
        });
  }
}

class ConfirmPasword extends StatelessWidget {
  const ConfirmPasword({
    Key? key,
    required this.confirmPasswordController,
    required this.validator,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController confirmPasswordController;
  final AuthValidator validator;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Confirm Password",
        isObscure: true,
        controller: confirmPasswordController,
        validator: (value) => validator.passwordValidation(value,
            isConfirm: true, textEditingController: passwordController),
        icon: Icons.lock);
  }
}

class Password extends StatelessWidget {
  const Password({
    Key? key,
    required this.passwordController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController passwordController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Password",
        isObscure: true,
        controller: passwordController,
        validator: (value) => validator.passwordValidation(value),
        icon: Icons.lock);
  }
}

class HomeAddress extends StatelessWidget {
  const HomeAddress({
    Key? key,
    required this.addressController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController addressController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Home Address",
        controller: addressController,
        validator: (value) => validator.emptyValidator(value),
        icon: Icons.home);
  }
}

class MobiliNumber extends StatelessWidget {
  const MobiliNumber({
    Key? key,
    required this.phoneNumberController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController phoneNumberController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Mobile Number",
        controller: phoneNumberController,
        validator: (value) => validator.emptyValidator(value),
        icon: Icons.add_call);
  }
}

class Email extends StatelessWidget {
  const Email({
    Key? key,
    required this.emailController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController emailController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Email",
        controller: emailController,
        validator: (value) => validator.emailValidation(value),
        icon: Icons.email);
  }
}

class FullName extends StatelessWidget {
  const FullName({
    Key? key,
    required this.nameController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController nameController;
  final AuthValidator validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "Full Name",
        controller: nameController,
        validator: (value) => validator.nameValidator(value),
        icon: Icons.person);
  }
}

class NavigateToLogin extends StatelessWidget {
  const NavigateToLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 35,
      //bottom: 0,
      child: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
