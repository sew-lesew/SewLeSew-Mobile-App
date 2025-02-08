import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';

import '../bloc/create_campaign_bloc/create_campaign_bloc.dart';
import '../bloc/create_campaign_bloc/create_campaign_event.dart';
import '../bloc/create_campaign_bloc/create_campaign_state.dart';
import '../widgets/bank_and_business.dart';
import '../widgets/basic_information.dart';
import '../widgets/document_upload.dart';
import '../widgets/facny_button.dart';
import '../widgets/location_and_campaign.dart';

class CreateCampaignForm extends StatefulWidget {
  const CreateCampaignForm({super.key});

  @override
  State<CreateCampaignForm> createState() => _CreateCampaignFormState();
}

class _CreateCampaignFormState extends State<CreateCampaignForm> {
  final formKey = GlobalKey<FormState>();

  final BusinessCampaignEntity campaignData =
      BusinessCampaignEntity.initialize();

  @override
  void initState() {
    super.initState();
    context.read<CreateCampaignBloc>();
  }

  // final List<LinearGradient> _pageGradients = [
  //   LinearGradient(
  //     colors: [Color(0xFF13ADB7), Color(0xFF0097D3)],
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight,
  //   ),
  //   LinearGradient(
  //     colors: [Color(0xFF005782), Color(0xFF0097D3)],
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight,
  //   ),
  //   LinearGradient(
  //     colors: [Color(0xFF212121), Color(0xFF005782)],
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight,
  //   ),
  //   LinearGradient(
  //     colors: [Color(0xFF0097D3), Color(0xFF13ADB7)],
  //     begin: Alignment.topLeft,
  //     end: Alignment.bottomRight,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCampaignBloc, CreateCampaignState>(
      listener: (context, state) {
        if (state.state.isSuccess == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Campaign created successfully!')),
          );
          Navigator.of(context).pop();
        } else if (state.state.failure != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to create campaign: ${state.state.failure}')),
          );
        }
      },
      builder: (context, state) {
        final currentPage = state.currentPage;

        return Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              // decoration: BoxDecoration(
              //   gradient: _pageGradients[currentPage],
              // ),
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
                      controller: PageController(initialPage: currentPage),
                      physics:
                          NeverScrollableScrollPhysics(), // Disable manual swiping
                      children: [
                        BasicInformationPage(
                            formKey: formKey, campaignData: campaignData),
                        LocationAndCampaignPage(
                            formKey: formKey, campaignData: campaignData),
                        BankAndBusinessPage(
                            formKey: formKey, campaignData: campaignData),
                        DocumentUploadsPage(formKey: formKey),
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
                                context
                                    .read<CreateCampaignBloc>()
                                    .add(SubmitFormEvent(campaignData));
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
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
