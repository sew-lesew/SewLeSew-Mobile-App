import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/config/routes/names.dart';
import 'package:sewlesew_fund/config/theme/colors.dart';
import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/features/explore/presentation/widgets/zigzagline.dart';
import 'package:share_plus/share_plus.dart';

import '../../../campaign/domain/entities/campaign_entity.dart';
import '../../../campaign/presentation/bloc/campaign_cubit.dart';
import '../../../campaign/presentation/pages/campaign_detail.dart';
import '../widgets/calculate_days_left.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignCubit>().getCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _headerSection(context),

            SizedBox(height: 16.h),

            // Categories Section
            _buildCategories(context),

            SizedBox(height: 16.h),

            // Featured Campaigns Section
            _featuredCampaignsSection(context),

            SizedBox(height: 16.h),

            // Call to Action
            _callToActionButton(context),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _headerSection(BuildContext context) {
    return Card(
      // color: AppColors.darkaccentColor,

      child: Container(
        padding: EdgeInsets.all(16.0.sp),
        decoration: const BoxDecoration(
          // color: AppColors.accentColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, John!",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "Your impact matters. Let’s make a difference today.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _quickActionButton(
                  title: "Make Donation",
                  icon: Icons.volunteer_activism,
                  onPressed: () {},
                ),
                _quickActionButton(
                  title: "Create Campaign",
                  icon: Icons.campaign,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Categories Section
  Widget _buildCategories(BuildContext context) {
    const categories = [
      {"title": "Education", "icon": Icons.school},
      {"title": "Health", "icon": Icons.health_and_safety},
      {"title": "Environment", "icon": Icons.eco},
      {"title": "Animals", "icon": Icons.pets},
      {"title": "Community", "icon": Icons.groups},
      {"title": "Others", "icon": Icons.more_horiz},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.cardColor.withOpacity(0.5),
                    child: Icon(
                      category['icon'] as IconData,
                      color: AppColors.accentColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['title'] as String,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Featured Campaigns
  Widget _featuredCampaignsSection(BuildContext context) {
    return Container(
      // color: AppColors.primaryBackground,
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text("Featured Campaigns",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(height: 8.h),
            BlocBuilder<CampaignCubit,
                GenericState<dartz.Either<Failure, Success>>>(
              builder: (context, state) {
                if (state.isLoading!) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.failure != null) {
                  return Center(
                      child: Text("Error: ${dartz.Left(state.failure!)}"));
                }

                final data = state.data;
                if (data == null || data.isLeft()) {
                  return const Center(child: Text("No campaigns found."));
                }

                final campaigns = (data as dartz.Right).value;
                print(campaigns);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      campaigns.length, // Replace with dynamic data length
                  itemBuilder: (context, index) {
                    final CampaignEntity campaign = campaigns[index];
                    return _campaignCard(
                      context,
                      campaignId: campaign.id,
                      goalAmount: campaign.goalAmount.toString(),
                      raisedAmount: campaign.raisedAmount.toString(),
                      status: campaign.status,
                      title: campaign.title,
                      description: campaign.description,
                      dayLeft: "${calculateDaysLeft(campaign.deadline)} days",
                      progress:
                          campaign.raisedAmount / campaign.goalAmount * 100,
                      donors: ["John", "Jane", "Alex"],
                      imageUrl: campaign.campaignMedia[0].url,
                      onDonateNowPressed: () {},
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Call to Action Button
  Widget _callToActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/explore');
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: AppColors.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Explore More Campaigns",
          style: TextStyle(fontSize: 18, color: AppColors.primaryBackground),
        ),
      ),
    );
  }

  // Quick Action Button
  Widget _quickActionButton(
      {required String title,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12.0.h),
        elevation: 2.0.h,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      icon: Icon(icon, size: 20.0.h),
      label: Text(title, style: TextStyle(fontSize: 12.0.h)),
    );
  }

  // Category Card
  Widget _categoryCard(
      {required String title,
      required IconData icon,
      required BuildContext context}) {
    return Container(
      width: 120.0.w,
      padding: EdgeInsets.all(8.0.h),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.accentColor, size: 22.0.h),
          SizedBox(height: 8.h),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _campaignCard(
    BuildContext context, {
    required String goalAmount,
    required String raisedAmount,
    required String campaignId,
    required String status,
    required String title,
    required String description,
    required String dayLeft,
    required double progress,
    required List<String> donors,
    required String imageUrl,
    required VoidCallback onDonateNowPressed,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CampaignDetailScreen(campaignId: campaignId)));
      },
      child: Stack(
        children: [
          Card(
            // color: AppColors.cardColor,
            margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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

                      SizedBox(height: 8.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                maxLines: 2,
                                description,
                                style: TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0.r)),
                              ),
                              child: Container(
                                height: 30.h,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: AppColors.accentColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.values[1],
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 12,
                                      color: AppColors.primaryBackground,
                                    ),
                                    Text(
                                      dayLeft,
                                      style: TextStyle(
                                        color: AppColors.primaryBackground,
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),

                      const SizedBox(height: 12),
                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("$raisedAmount birr raised",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Text("$goalAmount birr Needed",
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: progress / 100,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: const AlwaysStoppedAnimation(
                                AppColors.accentColor),
                          ),
                          Text(
                            "$progress% funded",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          // const SizedBox(height: 5),
                        ],
                      ),
                      // Donors Dropdown
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButton<String>(
                      //     hint: const Text("View Donors"),
                      //     icon: const Icon(
                      //       Icons.arrow_drop_down,
                      //       color: AppColors.accentColor,
                      //     ),
                      //     items: donors
                      //         .map((donor) => DropdownMenuItem<String>(
                      //               value: donor,
                      //               child: Text(donor),
                      //             ))
                      //         .toList(),
                      //     onChanged: (value) {
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //         content: Text("Donor: $value"),
                      //       ));
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 4.0.h),
                      const ZigzagLine(
                        height: 2.0,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 4.0.h),

                      // Donate Now Button
                      Container(
                        width: 300.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.PAYMENT);
                          },
                          // style: ElevatedButton.styleFrom(
                          //   padding: const EdgeInsets.symmetric(
                          //     vertical: 14,
                          //   ),
                          //   // backgroundColor: Colors.orangeAccent,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8)),
                          // ),
                          child: const Text(
                            "Donate Now",
                            style:
                                TextStyle(color: AppColors.primaryBackground),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Share Button Positioned on Top
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
                // backgroundColor: AppColors.cardColor,
                child: Icon(
                  Icons.share,
                  // color: AppColors.accentColor.withOpacity(0.5),
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
