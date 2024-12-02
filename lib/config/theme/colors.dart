import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color accentColor = Color(0xFF13ADB7);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFFEDEDED);
  static const Color lineColor = Color(0xFF979797);
  static const Color loadingColor = Color.fromARGB(135, 232, 227, 227);
  // Fresh and Lignt
  static const Color primaryBackground = Color(0xFFE5E5E5);

  static const Color primarySecondaryText = Colors.white;
  static const Color primaryText = Color(0xFF0C0E0A);
  static const Color secondaryColor = Color(0xFF0097D3);
}

class LightModeColors {
  static const Color cardColor = Color(0xFFFFFFFF);
  // for names and titles
  static const Color headlineLarge = Color(0xFF005782);

  // for username
  static const Color headlineMedium = Colors.black45;

// for details
  static Color? headlineSmall = Colors.grey[850];

  //static const Color secondaryText = Colors.black45;
  static const Color hintColor = Colors.black26;

  static const Color primaryColor = Color(0xFF005782);
  static const Color primarySecondaryText = Colors.grey;
  static const Color primaryText = Color(0xFF0C0E0A);
  static const Color secondaryColor = Color(0xFF0097D3);
}

class DarkModeColors {
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color hintColor = Colors.white38;
  static const Color primaryColor = Colors.black;
  static const Color primarySecondaryText = Color(0xFFB0B0B0);
  static const Color primaryText = Colors.white;
  static const Color secondaryColor = Color(0xFF0097D3);
  static const Color secondaryText = Color(0xFF8A8A8A);
}

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.highContrastLight(),
    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        headlineLarge: TextStyle(
            color: AppColors.primaryBackground,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp),
        headlineMedium: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
        headlineSmall: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
        titleLarge: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
        ),
        titleMedium: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.normal,
          fontSize: 13.sp,
        ),
        titleSmall: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.w300,
          fontSize: 11.sp,
        ),
      ),
    ),
  );
}
