// lib/features/campaign/presentation/widgets/location_and_campaign_page.dart
import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import 'input_card.dart';

class LocationAndCampaignPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final BusinessCampaignEntity campaignData;

  const LocationAndCampaignPage({
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
                icon: Icons.location_on,
                label: 'Region',
                hint: 'Enter your region',
                onSaved: (value) => campaignData.region = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Region is required';
                  }
                  return null;
                },
              ),
              InputCard(
                icon: Icons.location_city,
                label: 'City',
                hint: 'Enter your city',
                onSaved: (value) => campaignData.city = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
              InputCard(
                icon: Icons.place,
                label: 'Relative Location',
                hint: 'Enter your relative location',
                onSaved: (value) => campaignData.relativeLocation = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Relative location is required';
                  }
                  return null;
                },
              ),
              InputCard(
                icon: Icons.title,
                label: 'Title',
                hint: 'Enter campaign title',
                onSaved: (value) => campaignData.title = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              InputCard(
                icon: Icons.attach_money,
                label: 'Goal Amount',
                hint: 'Enter goal amount',
                onSaved: (value) =>
                    campaignData.goalAmount = double.tryParse(value ?? '0')!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Goal amount is required';
                  }
                  return null;
                },
              ),
              InputCard(
                icon: Icons.description,
                label: 'Description',
                hint: 'Enter campaign description',
                onSaved: (value) => campaignData.description = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
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
