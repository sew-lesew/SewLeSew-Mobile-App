import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import '../../../../core/resources/failure.dart';
import '../../../../core/resources/success.dart';

abstract class CampaignRepository {
  Future<Either<Failure, Success>> createBusinessCampaign(
      {BusinessCampaignEntity entity, required String campaignType});
  Future<Either<Failure, Success>> getCampaigns(
      {String? category, String? name});
  Future<Either<Failure, Success>> getMyCampaigns();
  Future<Either<Failure, Success>> getCampaignById(String id);
}
