import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/features/donations/domain/entities/donation_entity.dart';
import 'package:sewlesew_fund/features/donations/domain/repository/donation_repository.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';

class GetDonationByUserUseCase extends Usecase<List<DonationEntity>, void> {
  @override
  Future<List<DonationEntity>> call({void params}) async {
    return await sl<DonationRepository>().getDonationByUser();
  }
}
