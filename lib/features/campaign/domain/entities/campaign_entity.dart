import '../../../user_profile/domain/entities/user_entity.dart';

class CampaignEntity {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double goalAmount;
  final double raisedAmount;
  final String status;
  final DateTime createdAt;

  final UserEntity user;
  final List<String> categories;
  final List<CampaignMediaEntity> campaignMedia;
  final List<CampaignDocEntity> campaignDocs;

  CampaignEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.goalAmount,
    required this.raisedAmount,
    required this.status,
    required this.createdAt,
    required this.user,
    required this.categories,
    required this.campaignMedia,
    required this.campaignDocs,
  });
}

class CampaignMediaEntity {
  final String id;
  final String campaignId;
  final String url;

  CampaignMediaEntity({
    required this.id,
    required this.campaignId,
    required this.url,
  });
}

class CampaignDocEntity {
  final String id;
  final String campaignId;
  final String url;

  CampaignDocEntity({
    required this.id,
    required this.campaignId,
    required this.url,
  });
}

enum CampaignStatus { PENDING, ACTIVE, COMPLETED, REJECTED, REMOVED }
