import '../../../user_profile/data/model/user_model.dart';
import '../../domain/entities/campaign_entity.dart';

class CampaignModel {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final double goalAmount;
  final double raisedAmount;
  final CampaignStatus status;
  final DateTime? createdAt;

  final UserModel? user;
  final List<String> categories;
  final List<CampaignMediaModel> campaignMedia;
  final List<CampaignDocModel> campaignDocs;

  CampaignModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.goalAmount,
    required this.raisedAmount,
    required this.status,
    this.createdAt,
    this.user,
    required this.categories,
    required this.campaignMedia,
    required this.campaignDocs,
  });
}

class CampaignMediaModel {
  final String id;
  final String campaignId;
  final String url;

  CampaignMediaModel({
    required this.id,
    required this.campaignId,
    required this.url,
  });
}

class CampaignDocModel {
  final String id;
  final String campaignId;
  final String url;

  CampaignDocModel({
    required this.id,
    required this.campaignId,
    required this.url,
  });
}
