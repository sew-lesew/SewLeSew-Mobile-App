import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget headerSectionSkeleton(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  final Color highlightColor =
      isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;
  final Color cardColor = isDarkMode ? Colors.grey[850]! : Colors.white;

  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Card(
      color: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20.h,
              width: 150.w,
              color: baseColor,
            ),
            SizedBox(height: 8.h),
            Container(
              height: 14.h,
              width: 250.w,
              color: baseColor,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                2,
                (index) => Column(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: baseColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 14.h,
                      width: 80.w,
                      color: baseColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
