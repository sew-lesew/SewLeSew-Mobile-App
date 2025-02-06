import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import 'create_campaign_tab.dart';
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
