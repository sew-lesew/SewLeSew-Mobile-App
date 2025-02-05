import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/campaign_media_entity.dart';
import '../model/campaign_media_model.dart';
import '../model/campaign_model.dart';

class CampaignMapper {
  static CampaignEntity toEntity(CampaignModel model) {
    return CampaignEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      goalAmount: model.goalAmount,
      raisedAmount: model.raisedAmount,
      category: model.category,
      deadline: model.deadline,
      status: model.status,
      campaignMedia: model.campaignMedia
          .map((e) => CampaignMediaEntity(id: e.id, url: e.url))
          .toList(),
    );
  }

  static CampaignModel toModel(CampaignEntity entity) {
    return CampaignModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      goalAmount: entity.goalAmount,
      raisedAmount: entity.raisedAmount,
      category: entity.category,
      deadline: entity.deadline,
      status: entity.status,
      campaignMedia: entity.campaignMedia
          .map((e) => CampaignMediaModel(id: e.id, url: e.url))
          .toList(),
    );
  }
}
