import 'package:flutter/material.dart';
import 'package:unity_fund/features/donations/presentation/widgets/donation_widgets.dart';

import '../../../../config/theme/colors.dart';

class Donation extends StatelessWidget {
  const Donation({super.key});

  // Helper method to build a previous donation tile
  Widget _buildPreviousDonationTile() {
    return Card(
      // color: AppColors.cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.accentColor.withOpacity(0.5),
          child: const Icon(Icons.campaign, color: AppColors.accentColor),
        ),
        title: const Text(
          "Education for All Campaign",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          "Donated: 100birr\nDate: Nov 10, 2024",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: AppColors.accentColor),
      ),
    );
  }

  // Helper method to build an urgent campaign card
  Widget _buildUrgentCampaignCard() {
    return Card(
      // color: AppColors.cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(right: 10),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Help People Save Lives",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              "Deadline: 5 Days Left",
              style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.6, // Example progress
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(AppColors.accentColor),
            ),
            const SizedBox(height: 5),
            const Text(
              "Raised: 6,000birr of 10,000birr",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a cause card
  Widget _buildCauseCard(String title, IconData icon, BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.cardColor.withOpacity(0.5),
          child: Icon(icon, color: AppColors.accentColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: AppColors.primaryBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Urgent Campaigns Section
              lineWithText(text: " Urgent Campaigns", context: context),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Example campaigns
                  itemBuilder: (context, index) => _buildUrgentCampaignCard(),
                ),
              ),
              const SizedBox(height: 20),

              // Causes to Support Section
              lineWithText(text: " Causes to Support", context: context),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildCauseCard("Education", Icons.school, context),
                  _buildCauseCard("Healthcare", Icons.local_hospital, context),
                  _buildCauseCard("Disaster Relief", Icons.waves, context),
                  _buildCauseCard("Environment", Icons.eco, context),
                  _buildCauseCard("Animal Welfare", Icons.pets, context),
                  _buildCauseCard("Community Aid", Icons.people, context),
                ],
              ),
              const SizedBox(height: 20),

              // My Donations Section
              lineWithText(text: " My Donations", context: context),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3, // Example previous donations
                itemBuilder: (context, index) => _buildPreviousDonationTile(),
              ),
              const SizedBox(height: 20),

              // Final Note and Call to Action
              Center(
                child: Text(
                  "Your contribution will create a lasting impact!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentColor.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
