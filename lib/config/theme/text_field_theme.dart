import 'package:flutter/material.dart';

class TTextFieldTheme {
  TTextFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.grey,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.black12,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.orange,
      ),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle()
        .copyWith(fontSize: 14, color: Colors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.grey,
      ),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.white,
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.orange,
      ),
    ),
  );
  // static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  //   errorMaxLines: 3,
  //   prefixIconColor: Colors.grey,
  //   suffixIconColor: Colors.grey,
  //   constraints: BoxConstraints.expand(height: 14),
  //   labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
  //   hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
  //   errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
  //   floatingLabelStyle: TextStyle()
  //       .copyWith(fontSize: 14, color: Colors.white.withOpacity(0.8)),
  //   border: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(
  //       width: 1,
  //       color: Colors.grey,
  //     ),
  //   ),
  //   enabledBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(
  //       width: 1,
  //       color: Colors.grey,
  //     ),
  //   ),
  //   focusedBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(
  //       width: 1,
  //       color: Colors.white,
  //     ),
  //   ),
  //   errorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(
  //       width: 1,
  //       color: Colors.red,
  //     ),
  //   ),
  //   focusedErrorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(
  //       width: 1,
  //       color: Colors.orange,
  //     ),
  //   ),
  // );
}
