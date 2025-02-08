// lib/features/campaign/presentation/widgets/bank_and_business_page.dart
import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import 'input_card.dart';

class BankAndBusinessPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final BusinessCampaignEntity campaignData;

  const BankAndBusinessPage({
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
          child: Column(
            children: [
              InputCard(
                icon: Icons.account_balance,
                label: 'Bank Name',
                hint: 'Enter bank name',
                onSaved: (value) => campaignData.bankName = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bank name is required';
                  }
                  return null;
                },
              ),
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
              InputCard(
                icon: Icons.business,
                label: 'Sector',
                hint: 'Enter business sector',
                onSaved: (value) => campaignData.sector = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sector is required';
                  }
                  return null;
                },
              ),
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
              InputCard(
                icon: Icons.assignment,
                label: 'License Number',
                hint: 'Enter license number',
                onSaved: (value) => campaignData.licenseNumber = value ?? "",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'License number is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
