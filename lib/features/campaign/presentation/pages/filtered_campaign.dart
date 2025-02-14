import 'dart:async';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';

import '../../../../core/constants/enum_campaign.dart';
import '../../../../core/util/enum_string.dart';
import '../../../donations/presentation/pages/payment.dart';
import '../../../explore/presentation/widgets/calculate_days_left.dart';
import '../../../explore/presentation/widgets/campaign_card_shimmer.dart';
import '../../domain/entities/campaign_entity.dart';
import '../bloc/campaign_cubit.dart';
import '../widgets/campaign_card.dart';

class CategoryCampaignScreen extends StatefulWidget {
  final Category? category;

  const CategoryCampaignScreen({super.key, this.category});

  @override
  _CategoryCampaignScreenState createState() => _CategoryCampaignScreenState();
}

class _CategoryCampaignScreenState extends State<CategoryCampaignScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchCampaigns();

    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _fetchCampaigns();
      });
    });
  }

  void _fetchCampaigns() {
    context.read<CampaignCubit>().getCampaigns(
          category: widget.category.toString().split('.').last,
          name: _searchController.text,
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category != null
            ? enumToDisplayString(widget.category!)
            : "All Campaigns"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search campaigns...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CampaignCubit,
                GenericState<dartz.Either<Failure, Success>>>(
              builder: (context, state) {
                if (state.isLoading!) {
                  return campaignCardSkeleton(context);
                }
                // if (state.failure != null) {
                //   return Center(
                //       child: Text("Error: ${dartz.Left(state.failure!)}"));
                // }
                final data = state.data;
                if (data == null || data.isLeft()) {
                  return const Center(child: Text("No campaigns found."));
                }
                final campaignData = (data as dartz.Right).value;
                final List<CampaignEntity> campaigns =
                    campaignData.campaigns ?? [];
                print(campaigns);
                return ListView.builder(
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    final CampaignEntity campaign = campaigns[index];
                    return CampaignCard(
                      goalAmount: campaign.goalAmount.toString(),
                      raisedAmount: campaign.raisedAmount.toString(),
                      campaignId: campaign.id,
                      status: campaign.status,
                      title: campaign.title,
                      description: campaign.description,
                      dayLeft: "${calculateDaysLeft(campaign.deadline)} days",
                      progress: double.parse(
                          (campaign.raisedAmount / campaign.goalAmount * 100)
                              .toStringAsFixed(2)),
                      donors: campaign.donationCount,
                      imageUrl: campaign.campaignMedia[0].url,
                      onDonateNowPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DonatePayment(campaignId: campaign.id)));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
