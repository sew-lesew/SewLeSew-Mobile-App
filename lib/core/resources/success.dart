import '../../features/campaign/domain/entities/campaign_detail_entity.dart';
import '../../features/campaign/domain/entities/campaign_entity.dart';

class Success {
  final String? message;
  final List<CampaignEntity>? campaigns;
  final CampaignDetailEntity? campaignDetailEntity;
  Success({required this.message, this.campaigns, this.campaignDetailEntity});
}
