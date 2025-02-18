import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/core/usecase/usecase.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import 'package:sewlesew_fund/features/campaign/domain/repository/campaign_repository.dart';
import '../../../../injection_container.dart';

class CreateBusinessCampaignUsecase
    extends Usecase<Either<Failure, Success>, CreateBusinessCampaignParams> {
  @override
  Future<Either<Failure, Success>> call(
      {CreateBusinessCampaignParams? params}) async {
    return await sl<CampaignRepository>().createBusinessCampaign(
        entity: params!.entity, campaignType: params.campaignType);
  }
}

class CreateBusinessCampaignParams {
  final BusinessCampaignEntity entity;
  final String campaignType;

  CreateBusinessCampaignParams({
    required this.entity,
    required this.campaignType,
  });
}
