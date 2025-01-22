import 'package:flutter/material.dart';

import 'package:regexpattern/regexpattern.dart';

import 'ethiopian_phone_validator.dart';

class SignInController {
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? handleSignIn(String fieldName, String value) {
    print("phoneOrEmail: ${contactController.text}");
    switch (fieldName) {
      case 'contact':
        if (value.isEmpty) {
          return "Email or phone number can't be empty";
        }
        if (!EthiopianPhoneValidator.isValidPhoneNumber(value) &&
            !value.isEmail()) {
          return "Please enter a valid phone number or email address";
        }

        break;
      case 'password':
        if (value.isEmpty) {
          return "Password can't be empty ";
        }
        break;

      default:
        return null;
    }

    return null;
  }
}
