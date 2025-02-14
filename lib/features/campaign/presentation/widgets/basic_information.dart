import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import '../../../../core/util/ethiopian_phone_validator.dart';
import 'input_card.dart';

class BasicInformationPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final BusinessCampaignEntity campaignData;

  const BasicInformationPage({
    super.key,
    required this.formKey,
    required this.campaignData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputCard(
                  icon: Icons.person,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  onSaved: (value) => campaignData.fullName = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),
                InputCard(
                  icon: Icons.email,
                  label: 'Public Email',
                  hint: 'Enter your public email',
                  onSaved: (value) => campaignData.publicEmail = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Public email is required';
                    }
                    return null;
                  },
                ),
                InputCard(
                  icon: Icons.phone,
                  label: 'Public Phone Number',
                  hint: 'Enter your public phone number',
                  onSaved: (value) => campaignData.publicPhoneNumber =
                      EthiopianPhoneValidator.normalize(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Public phone number is required';
                    }
                    return null;
                  },
                ),
                InputCard(
                  icon: Icons.email,
                  label: 'Contact Email',
                  hint: 'Enter your contact email',
                  onSaved: (value) => campaignData.contactEmail = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact email is required';
                    }
                    return null;
                  },
                ),
                InputCard(
                  icon: Icons.phone,
                  label: 'Contact Phone Number',
                  hint: 'Enter your contact phone number',
                  onSaved: (value) => campaignData.contactPhoneNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact phone number is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
