import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:sewlesew_fund/core/resources/success_failure.dart';

import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/features/campaign/presentation/pages/campaign_detail.dart';
import '../../domain/entities/campaign_entity.dart';
import '../bloc/campaign_cubit.dart';

class MyCampaignsTab extends StatefulWidget {
  const MyCampaignsTab({super.key});

  @override
  State<MyCampaignsTab> createState() => _MyCampaignsTabState();
}

class _MyCampaignsTabState extends State<MyCampaignsTab> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignCubit>().getMyCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignCubit,
        GenericState<dartz.Either<Failure, Success>>>(
      builder: (context, state) {
        if (state.isLoading!) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.failure != null) {
          return Center(child: Text(state.failure!));
        }

        final data = state.data;
        if (data == null || data.isLeft()) {
          return const Center(child: Text("No campaigns found."));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: "Edit Campaign",
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: "Delete Campaign",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
