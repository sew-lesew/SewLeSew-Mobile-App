import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import 'my_campaigns_tab.dart';

class Campaign extends StatelessWidget {
  const Campaign({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        // backgroundColor: AppColors.primaryBackground,
        appBar: TabBar(
          isScrollable: true,
          indicatorColor: AppColors.accentColor,
          indicatorWeight: 3,
          labelColor: AppColors.accentColor,
          dividerColor: AppColors.greyColor,
          dividerHeight: 2,
          labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          tabs: [
            Tab(text: "Create"),
            Tab(text: "My Campaigns"),
            Tab(text: "Pending"),
            Tab(text: "Deleted"),
          ],
        ),
        body: TabBarView(
          children: [
            CreateCampaignTab(),
            MyCampaignsTab(),
            PendingCampaignsTab(),
            DeletedCampaignsTab(),
          ],
        ),
      ),
    );
  }
}

class CreateCampaignTab extends StatelessWidget {
  const CreateCampaignTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create a New Campaign",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Campaign Title
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Campaign Title",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 15),
            // Campaign Description
            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Campaign Description",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 15),
            // Campaign Goal
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Goal Amount (Birr)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 15),
            // Upload Image Button
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {}, // Add image upload functionality
                  icon: const Icon(Icons.image),
                  label: const Text("Upload Campaign Image"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {}, // Add campaign creation logic
                // style: ElevatedButton.styleFrom(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                //   backgroundColor: AppColors.accentColor,
                // ),
                child: const Text(
                  "Create Campaign",
                  // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingCampaignsTab extends StatelessWidget {
  const PendingCampaignsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Pending Campaigns Yet!",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}

class DeletedCampaignsTab extends StatelessWidget {
  const DeletedCampaignsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No Deleted Campaigns Yet!",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
