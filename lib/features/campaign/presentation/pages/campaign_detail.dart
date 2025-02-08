import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/config/theme/colors.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/resources/generic_state.dart';
import '../../domain/entities/campaign_detail_entity.dart';
import '../bloc/campaign_cubit.dart';

class CampaignDetailScreen extends StatefulWidget {
  final String? campaignId;
  const CampaignDetailScreen({super.key, this.campaignId});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignCubit>().getCampaignById(widget.campaignId!);
  }

  @override
  Widget build(BuildContext context) {
    print("campaingid is ${widget.campaignId}");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Campaign Details"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<CampaignCubit,
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
            final successData = (data as dartz.Right).value;
            final CampaignDetailEntity campaign =
                successData.campaignDetailEntity;

            return Column(
              children: [
                // Campaign Image
                Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      child: CachedNetworkImage(
                        imageUrl: campaign.campaignMedia[0].url,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.red, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Share.share("Check out this campaign:\n\n"
                              "Title: ${campaign.title}\n"
                              "Creator: ${campaign.business!.fullName}\n\n"
                              "Description: ${campaign.description}\n\n"
                              "Donate now to support this campaign.");
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primaryBackground,
                          child: Icon(
                            Icons.share,
                            color: AppColors.accentColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Campaigner Info
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.campaign,
                          color: AppColors.accentColor, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Campaigner",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Text(
                              campaign.business!.fullName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Donors"),
                              content: Text("2 donors"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.people,
                                color: Colors.grey, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              "3 Donors",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Donate Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle donation logic
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Center(
                      child: Text(
                        "Donate Now",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
// add tab bar controller

                // DefaultTabController for managing tabs
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      // Story Section
                      const TabBar(
                        labelColor: AppColors.accentColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: AppColors.accentColor,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: "Story"),
                          Tab(text: "Documents"),
                        ],
                      ),

                      SizedBox(
                        height: 200.h,
                        child: TabBarView(
                          children: [
                            // Story Section
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Story",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.accentColor,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "This is the story section where the purpose of the campaign, "
                                      "background details, and any other information can be shared.",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Documents Section
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: campaign.campaignMedia.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // Add document viewing logic here
                                          },
                                          child: Container(
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl: campaign
                                                        .campaignMedia[index]
                                                        .url,
                                                    width: 100,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  campaign.campaignMedia[index]
                                                          .imageType ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
