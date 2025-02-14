import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';

import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/features/campaign/presentation/pages/campaign_detail.dart';
import '../../domain/entities/campaign_entity.dart';
import '../bloc/campaign_cubit.dart';
import '../widgets/my_campaign_card_skeleton.dart';

class ClosedCampaign extends StatefulWidget {
  const ClosedCampaign({super.key});

  @override
  State<ClosedCampaign> createState() => _ClosedCampaignState();
}

class _ClosedCampaignState extends State<ClosedCampaign> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignCubit>().getMyCampaigns(camapignStatus: "CLOSED");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignCubit,
        GenericState<dartz.Either<Failure, Success>>>(
      builder: (context, state) {
        if (state.isLoading!) {
          return myCampaignCardSkeleton(context);
        }

        // if (state.failure != null) {
        //   return Center(child: Text(state.failure!));
        // }

        final data = state.data;
        if (data == null || data.isLeft()) {
          return const Center(child: Text("No Pending campaigns found."));
        }
        final successData = (data as dartz.Right<Failure, Success>).value;
        final List<CampaignEntity> campaigns = successData.campaigns ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: campaigns.length,
          itemBuilder: (context, index) {
            final campaign = campaigns[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CampaignDetailScreen(campaignId: campaign.id))),
              child: _buildCampaignCard(
                imageUrl: campaign.campaignMedia[0].url,
                title: campaign.title,
                status: campaign.status,
                raised: campaign.raisedAmount,
                goal: campaign.goalAmount,
                onEdit: () {
                  // Implement edit functionality
                },
                onDelete: () {
                  // Implement delete functionality
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCampaignCard({
    required String title,
    required String status,
    required String imageUrl,
    required double raised,
    required double goal,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                  image: CachedNetworkImageProvider(imageUrl),
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("Status: $status",
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Progress", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: raised / goal,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  ),
                  const SizedBox(height: 5),
                  Text("Raised: $raised Birr / $goal Birr",
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
