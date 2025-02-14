import '../../domain/entities/campaign_detail_entity.dart';
import '../../domain/entities/campaign_media_entity.dart';
import '../model/campaign_detail_model.dart';
import '../model/campaign_media_model.dart';

class CampaignDetailMapper {
  static CampaignDetailEntity toEntity(CampaignDetailModel model) {
    return CampaignDetailEntity(
      id: model.id,
      userId: model.userId,
      title: model.title,
      description: model.description,
      goalAmount: model.goalAmount,
      category: model.category,
      raisedAmount: model.raisedAmount,
      status: model.status,
      deadline: model.deadline,
      // createdAt: model.createdAt,
      // updatedAt: model.updatedAt,
      businessId: model.businessId,
      // charityId: model.charityId,
      business: model.business != null
          ? BusinessMapper.toEntity(model.business!)
          : null,
      campaignMedia:
          model.campaignMedia.map(CampaignMediaMapper.toEntity).toList(),
    );
  }

  static CampaignDetailModel fromEntity(CampaignDetailEntity entity) {
    return CampaignDetailModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      goalAmount: entity.goalAmount,
      category: entity.category,
      raisedAmount: entity.raisedAmount,
      status: entity.status,
      deadline: entity.deadline,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      businessId: entity.businessId,
      // charityId: entity.charityId,
      business: entity.business != null
          ? BusinessMapper.fromEntity(entity.business!)
          : null,
      campaignMedia:
          entity.campaignMedia.map(CampaignMediaMapper.fromEntity).toList(),
    );
  }
}

class BusinessMapper {
  static BusinessEntity toEntity(BusinessModel model) {
    return BusinessEntity(
      id: model.id,
      fullName: model.fullName,
      website: model.website,
      sector: model.sector,
      publicEmail: model.publicEmail,
      publicPhoneNumber: model.publicPhoneNumber,
      region: model.region,
      city: model.city,
      relativeLocation: model.relativeLocation,
      createdAt: model.createdAt,
    );
  }

  static BusinessModel fromEntity(BusinessEntity entity) {
    return BusinessModel(
      id: entity.id,
      fullName: entity.fullName,
      website: entity.website,
      sector: entity.sector,
      publicEmail: entity.publicEmail,
      publicPhoneNumber: entity.publicPhoneNumber,
      region: entity.region,
      city: entity.city,
      relativeLocation: entity.relativeLocation,
      createdAt: entity.createdAt,
    );
  }
}

class CampaignMediaMapper {
  static CampaignMediaEntity toEntity(CampaignMediaModel model) {
    return CampaignMediaEntity(
      id: model.id,
      campaignId: model.campaignId,
      url: model.url,
      imageType: model.imageType,
      createdAt: model.createdAt,
    );
  }

  static CampaignMediaModel fromEntity(CampaignMediaEntity entity) {
    return CampaignMediaModel(
      id: entity.id,
      campaignId: entity.campaignId,
      url: entity.url,
      imageType: entity.imageType,
      createdAt: entity.createdAt,
    );
  }
}
