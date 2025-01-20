import '../../../user_profile/data/model/user_model.dart';
import '../../../user_profile/domain/entities/user_entity.dart';
import '../../domain/entities/campaign_entity.dart';
import '../model/campaign_model.dart';

class UserMapper {
  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      campaigns: entity.campaigns
          .map((campaign) => CampaignMapper.fromEntity(campaign))
          .toList(),
    );
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id ?? '',
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      campaigns: model.campaigns
          .map((campaign) => CampaignMapper.toEntity(campaign))
          .toList(),
    );
  }
}

class CampaignMapper {
  static CampaignModel fromEntity(CampaignEntity entity) {
    return CampaignModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      goalAmount: entity.goalAmount,
      raisedAmount: entity.raisedAmount,
      status: _mapStatus(entity.status),
      categories: _mapCategories(
          entity.categories), // Mapping the categories as list of strings
      campaignMedia: entity.campaignMedia
          .map((media) => CampaignMediaMapper.fromEntity(media))
          .toList(),
      campaignDocs: entity.campaignDocs
          .map((doc) => CampaignDocMapper.fromEntity(doc))
          .toList(),
    );
  }

  static List<String> _mapCategories(List<String> categories) {
    return categories;
  }

  static CampaignStatus _mapStatus(String status) {
    switch (status) {
      case 'PENDING':
        return CampaignStatus.PENDING;
      case 'ACTIVE':
        return CampaignStatus.ACTIVE;
      case 'COMPLETED':
        return CampaignStatus.COMPLETED;
      case 'REJECTED':
        return CampaignStatus.REJECTED;
      case 'REMOVED':
        return CampaignStatus.REMOVED;
      default:
        throw Exception('Unknown campaign status: $status');
    }
  }

  static CampaignEntity toEntity(CampaignModel model) {
    return CampaignEntity(
      id: model.id ?? '',
      userId: model.userId,
      title: model.title,
      description: model.description,
      goalAmount: model.goalAmount,
      raisedAmount: model.raisedAmount,
      status: model.status.toString().split('.').last,
      categories: model.categories, // Directly map list of categories (strings)
      campaignMedia: model.campaignMedia
          .map((media) => CampaignMediaMapper.toEntity(media))
          .toList(),
      campaignDocs: model.campaignDocs
          .map((doc) => CampaignDocMapper.toEntity(doc))
          .toList(),
      createdAt: model.createdAt ?? DateTime.now(),
      user: UserMapper.toEntity(model.user!),
    );
  }
}

class CampaignMediaMapper {
  static CampaignMediaModel fromEntity(CampaignMediaEntity entity) {
    return CampaignMediaModel(
      id: entity.id,
      campaignId: entity.campaignId,
      url: entity.url,
    );
  }

  static CampaignMediaEntity toEntity(CampaignMediaModel model) {
    return CampaignMediaEntity(
      id: model.id,
      campaignId: model.campaignId,
      url: model.url,
    );
  }
}

class CampaignDocMapper {
  static CampaignDocModel fromEntity(CampaignDocEntity entity) {
    return CampaignDocModel(
      id: entity.id,
      campaignId: entity.campaignId,
      url: entity.url,
    );
  }

  static CampaignDocEntity toEntity(CampaignDocModel model) {
    return CampaignDocEntity(
      id: model.id,
      campaignId: model.campaignId,
      url: model.url,
    );
  }
}
