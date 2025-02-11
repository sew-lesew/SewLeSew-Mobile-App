import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';

import '../../data/mapper/business_campaign_mapper.dart';
import '../bloc/create_campaign_bloc/create_campaign_bloc.dart';
import '../bloc/create_campaign_bloc/create_campaign_event.dart';
import '../bloc/create_campaign_bloc/create_campaign_state.dart';
import '../widgets/bank_and_business.dart';
import '../widgets/basic_information.dart';
import '../widgets/document_upload.dart';
import '../widgets/facny_button.dart';
import '../widgets/location_and_campaign.dart';

class CreateCampaignForm extends StatefulWidget {
  final String campaignType;

  const CreateCampaignForm({super.key, required this.campaignType});

  @override
  State<CreateCampaignForm> createState() => _CreateCampaignFormState();
}

class _CreateCampaignFormState extends State<CreateCampaignForm> {
  final formKey = GlobalKey<FormState>();
  late PageController _pageController;
  final BusinessCampaignEntity campaignData =
      BusinessCampaignEntity.initialize();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<CreateCampaignBloc>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create ${widget.campaignType} Campaign',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<CreateCampaignBloc, CreateCampaignState>(
        listener: (context, state) {
          if (state.state.isSuccess == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Campaign created successfully!')),
            );
            Navigator.of(context).pop();
          } else if (state.state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.state.failure}'),
              ),
            );
          }
        },
        builder: (context, state) {
          final currentPage = state.currentPage;

          // Update the page controller after the current page changes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.page?.round() != currentPage) {
              _pageController.jumpToPage(currentPage);
            }
          });

          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),
                    LinearProgressIndicator(
                      value: (currentPage + 1) / 4,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          BasicInformationPage(
                            key: ValueKey(
                                'basic_info_$currentPage'), // Unique key
                            formKey: formKey,
                            campaignData: campaignData,
                          ),
                          LocationAndCampaignPage(
                            key: ValueKey(
                                'location_campaign_$currentPage'), // Unique key
                            formKey: formKey,
                            campaignData: campaignData,
                          ),
                          BankAndBusinessPage(
                            key: ValueKey(
                                'bank_business_$currentPage'), // Unique key
                            formKey: formKey,
                            campaignData: campaignData,
                            campaignType: widget.campaignType,
                          ),
                          DocumentUploadsPage(
                            key: ValueKey(
                                'document_upload_$currentPage'), // Unique key
                            formKey: formKey,
                            campaignData: campaignData,
                            campaignType: widget.campaignType,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (currentPage > 0)
                            FancyButton(
                              text: 'Back',
                              icon: Icons.arrow_back,
                              onPressed: () {
                                context
                                    .read<CreateCampaignBloc>()
                                    .add(PreviousPageEvent());
                              },
                            ),
                          if (currentPage < 3)
                            FancyButton(
                              text: 'Next',
                              icon: Icons.arrow_forward,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  context
                                      .read<CreateCampaignBloc>()
                                      .add(NextPageEvent(campaignData));
                                  print(
                                      "Campaign Data to model: ${BusinessCampaignMapper.fromEntity(campaignData).toJson()}");
                                }
                              },
                            ),
                          if (currentPage == 3)
                            FancyButton(
                              text: 'Submit',
                              icon: Icons.check,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  context.read<CreateCampaignBloc>().add(
                                      SubmitFormEvent(
                                          campaignData, widget.campaignType));
                                  // to print all data of the campaign entity not to print an instance of C
                                  print(
                                      "Campaign Data to submit: ${BusinessCampaignMapper.fromEntity(campaignData).toJson()}");
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (state.state.isLoading == true)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
