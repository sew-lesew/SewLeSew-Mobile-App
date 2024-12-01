import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unity_fund/config/theme/colors.dart';
import 'package:unity_fund/features/explore/presentation/widgets/zigzagline.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.primaryBackground,
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
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome, John!",
              style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          const Text(
            "Your impact matters. Let’s make a difference today.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
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
    );
  }

  // Categories Section
  // Categories Section Widget
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
                    backgroundColor: Colors.teal[100],
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colors.teal,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['title'] as String,
                    style: Theme.of(context).textTheme.titleMedium,
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
      color: AppColors.primaryBackground,
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Replace with dynamic data length
              itemBuilder: (context, index) {
                return _campaignCard(
                  context,
                  title: "Help Build a School",
                  creator: "Posted by Sarah Connor",
                  description:
                      "Support the construction of schools in rural areas.",
                  progress: 75,
                  donors: ["John", "Jane", "Alex"],
                  imageUrl: "assets/welcome/welcome1.png",
                  onDonateNowPressed: () {},
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
          backgroundColor: Colors.teal,
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        padding: EdgeInsets.all(12.0.h),
        elevation: 2.0.h,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12.0.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.teal, size: 22.0.h),
          SizedBox(height: 8.h),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  // Campaign Card
  Widget _campaignCard(
    BuildContext context, {
    required String title,
    required String creator,
    required String description,
    required double progress,
    required List<String> donors,
    required String imageUrl,
    required VoidCallback onDonateNowPressed,
  }) {
    return Card(
      color: AppColors.greyColor,
      margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const Icon(Icons.person, size: 20, color: Colors.teal),
                    const SizedBox(width: 5),
                    Text(
                      "By $creator",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Progress",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation(Colors.teal),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$progress% funded",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ), // Donors Dropdown
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text("View Donors"),
                    // isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
                    items: donors
                        .map((donor) => DropdownMenuItem<String>(
                              value: donor,
                              child: Text(donor),
                            ))
                        .toList(),
                    onChanged: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Donor: $value"),
                      ));
                    },
                  ),
                ),
                SizedBox(height: 4.0.h),
                const Zigzagline(
                  height: 2.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                SizedBox(height: 4.0.h),

                // Donate Now Button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Donate Now clicked!"),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromWidth(double.infinity),
                      maximumSize: const Size.fromWidth(double.infinity),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Donate Now",
                      style: TextStyle(color: AppColors.primaryBackground),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
