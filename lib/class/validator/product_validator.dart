import 'package:flutter/material.dart';

class ProductValidator {
  dynamic name(String value) {
    if (value.isEmpty) {
      return "Please enter your product name";
    }
    if (value.length < 3) {
      return "Product name cant be less than 3 characters";
    }
    return null;
  }

  dynamic price(String value) {
    if (value.isEmpty) {
      return "Please enter your product price";
    }
    if (!RegExp("[0-1]+").hasMatch(value)) {
      return "Product price must be a digit";
    }
  }

  dynamic description(String value) {
    if (value.isEmpty) {
      return "Please enter your product description";
    }

    if (value.length < 10) {
      return "Product name cant be less than 10 characters";
    }
    return null;
  }

  dynamic isEmpty(String value) {
    if (value.isEmpty) {
      return "Please enter your product description";
    }
    return null;
  }
}
class ClearFields{
  void clearTextField({required List<TextEditingController> controllers}) {
    
    for (TextEditingController controller in controllers) {
      controller.clear();
    }
  }
}
