import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unity_fund/config/theme/colors.dart';

class TBottomNavigationTheme {
  TBottomNavigationTheme._();
  static BottomNavigationBarThemeData lightBottomNavigationTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.cardColor,
    selectedItemColor: AppColors.accentColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  );
  static BottomNavigationBarThemeData darkBottomNavigationTheme =
      BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: AppColors.cardColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  );
}
