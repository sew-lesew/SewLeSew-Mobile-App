import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    this.readOnly = false,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.textColor = Colors.black,
    this.iconColor = const Color.fromARGB(255, 209, 160, 228),
    this.inputFormatters,
  });

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String? errorMsg;
  final FocusNode? focusNode;
  final String hintText;
  final Color iconColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  bool readOnly = false;
  final Widget? suffixIcon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      // onTap: onTap,
      textInputAction: TextInputAction.next,
      validator: validator,
      // style: TextStyle(color: textColor),
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(color: iconColor), child: suffixIcon!)
            : null,
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: const IconThemeData(
                    color: AppColors.accentColor), // Set icon color here
                child: prefixIcon!,
              )
            : null,
        iconColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        errorText: errorMsg,
      ),
    );
  }
}
