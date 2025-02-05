import 'package:equatable/equatable.dart';

import 'campaign_media_entity.dart';

class CampaignEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double goalAmount;
  final double raisedAmount;
  final String category;
  final DateTime deadline;
  final String status;
  final List<CampaignMediaEntity> campaignMedia;

  const CampaignEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.goalAmount,
    required this.raisedAmount,
    required this.category,
    required this.deadline,
    required this.status,
    required this.campaignMedia,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        goalAmount,
        raisedAmount,
        category,
        deadline,
        status,
        campaignMedia
      ];
}
