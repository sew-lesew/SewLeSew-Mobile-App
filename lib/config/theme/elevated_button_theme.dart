import 'package:flutter/material.dart';
import 'package:sewlesew_fund/config/theme/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.accentColor,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          // side: const BorderSide(color: AppColors.accentColor),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.accentColor,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          // side: const BorderSide(color: AppColors.accentColor),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
}
