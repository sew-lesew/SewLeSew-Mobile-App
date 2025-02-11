import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/core/usecase/usecase.dart';
import 'package:sewlesew_fund/features/campaign/domain/repository/campaign_repository.dart';
import '../../../../injection_container.dart';

class GetCampaignsUsecase
    extends Usecase<Either<Failure, Success>, CampaignParameter> {
  @override
  Future<Either<Failure, Success>> call({CampaignParameter? params}) async {
    return await sl<CampaignRepository>()
        .getCampaigns(category: params!.category, name: params.name);
  }
}

// parameter for get campaigns
class CampaignParameter {
  final String? category;
  final String? name;

  CampaignParameter({this.category, this.name});
}
