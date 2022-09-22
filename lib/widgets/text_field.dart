import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.hintText,
      required this.controller,
      required this.validator,
      this.icon = Icons.data_array,
      this.allowIcon = true,
      this.isObscure = false,
      this.isSearch = false,
      this.enable = true,
      Key? key})
      : super(key: key);
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final bool isSearch;
  final bool allowIcon;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      obscureText: isObscure,
      autofocus: false,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return validator(value);
      },
      onSaved: (value) {
        controller.text = value!;
      },
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: isSearch
            ? null
            : Text(
                hintText,
                style: const TextStyle(color: Colors.grey),
              ),
        prefixIcon: !allowIcon ? null : Icon(icon, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: !allowIcon
            ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: Colors.black12,
                ))
            : const UnderlineInputBorder(
                borderSide: BorderSide(
                color: Colors.grey,
              )),
        // border: OutlineInputBorder(
        //   // borderSide: BorderSide(
        //   //   color: Colors.red,
        //   //   width: 2,
        //   //   style: BorderStyle.solid,
        //   // ),
        //   borderRadius: BorderRadius.circular(10),
        // ),
      ),
    );
  }
}
