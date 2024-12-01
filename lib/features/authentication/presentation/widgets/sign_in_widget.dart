import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/colors.dart';

AppBar buildAppBar() {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.primaryBackground,
        // height defines the thickness of the line
        height: 1.0,
      ),
    ),
    title: Center(
      child: Text('Log In',
          style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal)),
    ),
  );
}

//Need Context for accesssing Bloc
Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
    padding: EdgeInsets.only(left: 35.w, right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableIcons("google"),
        _reusableIcons('apple'),
        _reusableIcons("facebook"),
      ],
    ),
  );
}

Widget _reusableIcons(String iconName) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: 40.w,
      height: 40.w,
      child: Image.asset("assets/icons/$iconName.png"),
    ),
  );
}

Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),
    ),
  );
}

Widget forgotPassword(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 25.h),
    width: 260.w,
    height: 44.h,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/reset_screen");
      },
      child: Text(
        "Forgot password",
        style: TextStyle(
          color: AppColors.primaryText,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryText,
          fontSize: 12.sp,
        ),
      ),
    ),
  );
}

Widget buildLogInAndRegButton(
    String buttonName, String buttonType, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
        margin: EdgeInsets.only(
            left: 25.w, right: 25.w, top: buttonType == "login" ? 35.h : 20.h),
        width: 325.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: buttonType == "login"
                ? AppColors.accentColor
                : AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(
                color: buttonType == "login"
                    ? Colors.transparent
                    : AppColors.cardColor),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
                color: AppColors.cardColor,
              )
            ]),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: buttonType == "login"
                  ? AppColors.primaryBackground
                  : AppColors.primaryText,
            ),
          ),
        )),
  );
}
