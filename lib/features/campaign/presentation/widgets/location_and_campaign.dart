import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import '../../../../core/constants/enum_campaign.dart';
import 'dead_line_picker.dart';
import 'enum_dropdown.dart';
import 'input_card.dart';

class LocationAndCampaignPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final BusinessCampaignEntity campaignData;

  const LocationAndCampaignPage({
    super.key,
    required this.formKey,
    required this.campaignData,
  });

  @override
  State<LocationAndCampaignPage> createState() =>
      _LocationAndCampaignPageState();
}

class _LocationAndCampaignPageState extends State<LocationAndCampaignPage> {
  late TextEditingController _deadlineController;

  @override
  void initState() {
    super.initState();
    _deadlineController = TextEditingController();
  }

  @override
  void dispose() {
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputCard(
                  icon: Icons.location_on,
                  label: 'Region',
                  hint: 'Enter your region',
                  onSaved: (value) => widget.campaignData.region = value!,
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
                  onSaved: (value) => widget.campaignData.city = value!,
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
                  onSaved: (value) =>
                      widget.campaignData.relativeLocation = value,
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
                  onSaved: (value) => widget.campaignData.title = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                SimpleEnumDropdown<Category>(
                  label: 'Category',
                  value: widget.campaignData.category,
                  items: Category.values,
                  onChanged: (value) {
                    widget.campaignData.category = value;
                  },
                ),
                InputCard(
                  icon: Icons.attach_money,
                  label: 'Goal Amount',
                  hint: 'Enter goal amount',
                  onSaved: (value) => widget.campaignData.goalAmount =
                      int.tryParse(value ?? '0')!,
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
                  onSaved: (value) =>
                      widget.campaignData.description = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                // Dual Input Date Picker for Deadline
                DualInputDatePicker(
                  label: 'Deadline',
                  controller: _deadlineController,
                  onDateSelected: (date) {
                    widget.campaignData.deadline =
                        date?.toIso8601String() ?? '';
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
