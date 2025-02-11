import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/core/resources/generic_state.dart';

import '../../../../core/constants/enum_campaign.dart';
import '../../../../core/util/enum_string.dart';
import '../bloc/campaign_cubit.dart';
import '../widgets/campaign_card.dart';

class CategoryCampaignScreen extends StatefulWidget {
  final Category category;

  const CategoryCampaignScreen({super.key, required this.category});

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
        title: Text(enumToDisplayString(widget.category)),
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
            child: BlocBuilder<CampaignCubit, GenericState>(
              builder: (context, state) {
                if (state.isLoading!) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.failure != null) {
                  return Center(child: Text("Error: ${state.failure}"));
                } else if (state.data.isEmpty) {
                  return const Center(child: Text("No campaigns found"));
                }
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final campaign = state.data[index];
                    return CampaignCard(
                      goalAmount: campaign.goalAmount,
                      raisedAmount: campaign.raisedAmount,
                      campaignId: campaign.id,
                      status: campaign.status,
                      title: campaign.title,
                      description: campaign.description,
                      dayLeft: campaign.daysLeft,
                      progress: campaign.progress,
                      donors: campaign.donors,
                      imageUrl: campaign.imageUrl,
                      onDonateNowPressed: () {},
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
