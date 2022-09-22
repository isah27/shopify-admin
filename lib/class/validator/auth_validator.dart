class AuthValidator {
  dynamic emailValidation(value) {
    if (value!.isEmpty) {
      return ("Please enter your email");
    }
    // reg expression for email validation
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return ("Enter a valid email");
    }

    return null;
  }

  dynamic passwordValidation(value,
      {bool isConfirm = false, textEditingController}) {
    if (value!.isEmpty) {
      return ("Password is require for registration");
    }
    if (value.length < 6) {
      return ("Enter valid password(Min. 6 Character)");
    }

    if (isConfirm == true) {
      if (textEditingController.text != value) {
        return ("Password dont match");
      }
    }

    return null;
  }

  dynamic nameValidator(value) {
    if (value!.isEmpty) {
      return ("Enter your name");
    }
    if (value.length < 3) {
      return ("Enter valid name(Min. 3 Character)");
    }
    return null;
  }

  dynamic emptyValidator(value) {
    if (value!.isEmpty) {
      return ("This field is require for registration");
    }

    return null;
  }
}
