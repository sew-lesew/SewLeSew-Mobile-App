import 'package:flutter/material.dart';
import 'package:sewlesew_fund/config/theme/colors.dart';

class TAppBarTheme {
  TAppBarTheme._();
  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.accentColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white));
  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.darkaccentColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white));
}
