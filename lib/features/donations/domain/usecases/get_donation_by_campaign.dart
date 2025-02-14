import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/features/donations/domain/repository/donation_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';

class GetDonationByCampaignUseCase
    extends Usecase<Either<Failure, Success>, String> {
  @override
  Future<Either<Failure, Success>> call({String? params}) async {
    return await sl<DonationRepository>().getDonationByCampaign(params!);
  }
}
