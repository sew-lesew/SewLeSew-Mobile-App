import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget myCampaignCardSkeleton(BuildContext context) {
  // Determine the current theme (dark or light)
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  // Define colors based on the theme
  final Color baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  final Color highlightColor =
      isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

  return Shimmer.fromColors(
    baseColor: baseColor, // Dynamic base color
    highlightColor: highlightColor, // Dynamic highlight color
    child: Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton for the campaign image
            Container(
              width: double.infinity,
              height: 200.h,
              color: isDarkMode
                  ? Colors.grey[800]!
                  : Colors.white, // Dynamic placeholder color
            ),
            const SizedBox(height: 16),
            // Skeleton for the campaign title
            Container(
              width: double.infinity,
              height: 20,
              color: isDarkMode
                  ? Colors.grey[800]!
                  : Colors.white, // Dynamic placeholder color
            ),
            const SizedBox(height: 8),
            // Skeleton for the campaign status
            Container(
              width: 150,
              height: 15,
              color: isDarkMode
                  ? Colors.grey[800]!
                  : Colors.white, // Dynamic placeholder color
            ),
            const SizedBox(height: 16),
            // Skeleton for the progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton for the "Progress" text
                Container(
                  width: 80,
                  height: 15,
                  color: isDarkMode
                      ? Colors.grey[800]!
                      : Colors.white, // Dynamic placeholder color
                ),
                const SizedBox(height: 8),
                // Skeleton for the progress bar
                Container(
                  width: double.infinity,
                  height: 10,
                  color: isDarkMode
                      ? Colors.grey[800]!
                      : Colors.white, // Dynamic placeholder color
                ),
                const SizedBox(height: 8),
                // Skeleton for the raised/goal text
                Container(
                  width: 200,
                  height: 15,
                  color: isDarkMode
                      ? Colors.grey[800]!
                      : Colors.white, // Dynamic placeholder color
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Skeleton for the edit and delete buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey[800]!
                        : Colors.white, // Dynamic placeholder color
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey[800]!
                        : Colors.white, // Dynamic placeholder color
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
