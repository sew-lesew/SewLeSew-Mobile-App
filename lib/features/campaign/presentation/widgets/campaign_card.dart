import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../config/theme/colors.dart';
import '../../../explore/presentation/widgets/zigzagline.dart';
import '../pages/campaign_detail.dart';

class CampaignCard extends StatelessWidget {
  final String goalAmount;
  final String raisedAmount;
  final String campaignId;
  final String status;
  final String title;
  final String description;
  final String dayLeft;
  final double progress;
  final String donors;
  final String imageUrl;
  final VoidCallback onDonateNowPressed;

  const CampaignCard({
    super.key,
    required this.goalAmount,
    required this.raisedAmount,
    required this.campaignId,
    required this.status,
    required this.title,
    required this.description,
    required this.dayLeft,
    required this.progress,
    required this.donors,
    required this.imageUrl,
    required this.onDonateNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CampaignDetailScreen(campaignId: campaignId),
                    ),
                  ).then((_) {
                    // Handle any post-navigation actions if needed
                  });
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.h,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 30.h,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: AppColors.accentColor,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.timer_outlined,
                                        size: 12, color: Colors.white),
                                    SizedBox(width: 4.w),
                                    Text(
                                      dayLeft,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("$raisedAmount birr raised",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text("$goalAmount birr Needed",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              Text(("${donors.toString()} donors"),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey)), // donors
                              LinearProgressIndicator(
                                value: progress / 100,
                                backgroundColor: Colors.grey.shade300,
                                valueColor: AlwaysStoppedAnimation(
                                    AppColors.accentColor),
                              ),
                              Text("$progress% funded",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 4.0.h),
                          ZigzagLine(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.grey),
                          SizedBox(height: 4.0.h),
                        ],
                      ),
                    ),
                    Container(
                      width: 300.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ElevatedButton(
                        onPressed: onDonateNowPressed,
                        child: Text("Donate Now",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Share.share("Check out this campaign:\n\n"
                  "Title: $title\n"
                  "Description: $description\n\n"
                  "Progress: $progress\n\n"
                  "Donate now to support this campaign");
            },
            child: CircleAvatar(
              child: Icon(Icons.share, size: 28),
            ),
          ),
        ),
      ],
    );
  }
}
