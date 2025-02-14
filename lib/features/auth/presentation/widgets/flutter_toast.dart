import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../config/theme/colors.dart';

toastInfo({
  required String? msg,
  Color backgroundColor = Colors.black,
  Color textColor = AppColors.primaryBackground,
  ToastGravity gravity = ToastGravity.TOP,
}) {
  return Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 12.sp,
  );
}
