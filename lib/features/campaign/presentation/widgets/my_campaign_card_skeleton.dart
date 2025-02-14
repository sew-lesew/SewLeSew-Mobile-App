import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget myCampaignCardSkeleton(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  // Base colors for shimmer effect
  final Color baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  final Color highlightColor =
      isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

  // Contrasting background color for the card
  final Color cardColor = isDarkMode ? Colors.grey[850]! : Colors.white;

  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: cardColor, // Background color of the card
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Profile picture, name, and share button
            Row(
              children: [
                // Profile picture skeleton
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: highlightColor, // Contrasting element color
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w),
                // Name skeleton
                Expanded(
                  child: Container(
                    height: 16.h,
                    color: highlightColor, // Contrasting element color
                  ),
                ),
                SizedBox(width: 12.w),
                // Share button skeleton
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: highlightColor, // Contrasting element color
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Campaign Image
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: highlightColor, // Contrasting element color
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 16.h),
            // Campaign Title
            Container(
              width: double.infinity,
              height: 20.h,
              color: highlightColor,
            ),
            SizedBox(height: 8.h),
            // Campaign Status
            Container(
              width: 120.w,
              height: 14.h,
              color: highlightColor,
            ),
            SizedBox(height: 16.h),
            // Progress section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress label
                Container(
                  width: 80.w,
                  height: 14.h,
                  color: highlightColor,
                ),
                SizedBox(height: 8.h),
                // Progress bar skeleton
                Container(
                  width: double.infinity,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: highlightColor, // Contrasting element color
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                SizedBox(height: 8.h),
                // Amount raised / goal
                Container(
                  width: 180.w,
                  height: 14.h,
                  color: highlightColor,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Action buttons: Edit & Delete
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
