import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import '../../../../core/constants/enum_campaign.dart';
import 'enum_dropdown.dart';
import 'input_card.dart';

class BankAndBusinessPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final BusinessCampaignEntity campaignData;
  final String campaignType;

  const BankAndBusinessPage({
    super.key,
    required this.formKey,
    required this.campaignData,
    required this.campaignType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Bank Name Dropdown
                SimpleEnumDropdown<BankName>(
                  label: 'Bank Name',
                  value: campaignData.bankName,
                  items: BankName.values,
                  onChanged: (value) {
                    campaignData.bankName = value;
                  },
                ),

                // Holder Name Input
                InputCard(
                  icon: Icons.person,
                  label: 'Holder Name',
                  hint: 'Enter account holder name',
                  onSaved: (value) => campaignData.holderName = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Holder name is required';
                    }
                    return null;
                  },
                ),

                // Account Number Input
                InputCard(
                  icon: Icons.credit_card,
                  label: 'Account Number',
                  hint: 'Enter account number',
                  onSaved: (value) => campaignData.accountNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Account number is required';
                    }
                    return null;
                  },
                ),

                // Business Sector Dropdown which is for Business only make it based on the campaignType
                if (campaignType == 'Business') ...[
                  SimpleEnumDropdown<BusinessSector>(
                    label: 'Sector',
                    value: campaignData.sector,
                    items: BusinessSector.values,
                    onChanged: (value) {
                      campaignData.sector = value;
                    },
                  ),

                  // TIN Number Input only for Business
                  if (campaignType == 'Organizational' ||
                      campaignType == 'Business') ...[
                    InputCard(
                      icon: Icons.numbers,
                      label: 'TIN Number',
                      hint: 'Enter TIN number',
                      onSaved: (value) => campaignData.tinNumber = value ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'TIN number is required';
                        }
                        return null;
                      },
                    ),

                    // License Number Input only for business
                    InputCard(
                      icon: Icons.assignment,
                      label: 'License Number',
                      hint: 'Enter license number',
                      onSaved: (value) =>
                          campaignData.licenseNumber = value ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'License number is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
