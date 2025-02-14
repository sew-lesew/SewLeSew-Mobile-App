import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/core/usecase/usecase.dart';
import 'package:sewlesew_fund/features/campaign/domain/repository/campaign_repository.dart';
import '../../../../injection_container.dart';

class GetMyCampaignsUsecase extends Usecase<Either<Failure, Success>, String?> {
  @override
  Future<Either<Failure, Success>> call({String? params}) async {
    return await sl<CampaignRepository>()
        .getMyCampaigns(campaignStatus: params);
  }
}
