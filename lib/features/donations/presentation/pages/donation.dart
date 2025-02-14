import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/features/donations/presentation/widgets/donation_widgets.dart';

import '../../../../config/theme/colors.dart';
import '../../../auth/presentation/widgets/flutter_toast.dart';
import '../../../campaign/presentation/bloc/campaign_cubit.dart';
import '../../../campaign/presentation/pages/filtered_campaign.dart';
import '../../domain/entities/donation_entity.dart';
import '../bloc/donation_cubit.dart';
import 'donation_detail.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  @override
  void initState() {
    super.initState();
    // context.read<CampaignCubit>().getCampaigns();
    // context.read<DonationCubit>().getDonationByCampaign();
    context.read<DonationCubit>().getDonationByUser();
  }

  // Helper method to build a previous donation tile
  Widget _buildPreviousDonationTile() {
    return BlocBuilder<DonationCubit, GenericState>(
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // if (state.failure != null) {
        //   return toastInfo(msg: state.failure);
        // }

        final data = state.data as List<DonationEntity>;
        if (data.isEmpty) {
          return Text("No donations available");
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final donation = data[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonationDetail(donation: donation)));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.accentColor.withAlpha(128),
                    child: const Icon(Icons.campaign,
                        color: AppColors.accentColor),
                  ),
                  title: Text(
                    "${donation.donorFirstName} ${donation.donorLastName}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    "Amount: ${donation.amount} birr",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.accentColor),
                ),
              ),
            );
          },
        );
      },
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryCampaignScreen(),
          ),
        );
      },
      child: Column(
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
      ),
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
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
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
              _buildPreviousDonationTile(),
              // FutureBuilder(
              //   future: context.read<DonationCubit>().getDonationByUser(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(child: CircularProgressIndicator());
              //     } else if (snapshot.hasError) {
              //       return Center(child: Text('Error: ${snapshot.error}'));
              //     } else {
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: 3, // Example previous donations
              //         itemBuilder: (context, index) =>
              //             _buildPreviousDonationTile(),
              //       );
              //     }
              //   },
              // ),
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
