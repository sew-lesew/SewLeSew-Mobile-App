import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget campaignCardSkeleton(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  final Color baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  final Color highlightColor =
      isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            color: isDarkMode ? Colors.grey[800]! : Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for the campaign title
                Container(
                  width: double.infinity,
                  height: 20,
                  color: isDarkMode ? Colors.grey[800]! : Colors.white,
                ),
                SizedBox(height: 8.h),
                // Skeleton for the description and timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skeleton for the description
                    Container(
                      width: 150.w,
                      height: 40,
                      color: isDarkMode ? Colors.grey[800]! : Colors.white,
                    ),
                    // Skeleton for the timer
                    Container(
                      width: 80.w,
                      height: 30.h,
                      color: isDarkMode ? Colors.grey[800]! : Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Skeleton for the progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Skeleton for the raised and goal amounts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100.w,
                          height: 10,
                          color: isDarkMode ? Colors.grey[800]! : Colors.white,
                        ),
                        Container(
                          width: 100.w,
                          height: 10,
                          color: isDarkMode
                              ? Colors.grey[800]!
                              : Colors.white, // Dynamic placeholder color
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Skeleton for the progress bar
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: isDarkMode
                          ? Colors.grey[800]!
                          : Colors.white, // Dynamic placeholder color
                    ),
                    SizedBox(height: 8.h),
                    // Skeleton for the percentage funded
                    Container(
                      width: 80.w,
                      height: 10,
                      color: isDarkMode
                          ? Colors.grey[800]!
                          : Colors.white, // Dynamic placeholder color
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Skeleton for the donate now button
                Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey[800]!
                        : Colors.white, // Dynamic placeholder color
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
