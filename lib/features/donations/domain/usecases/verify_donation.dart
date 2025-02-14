import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repository/donation_repository.dart';

class VerifyDonationUseCase extends Usecase<Either<Failure, Success>, String> {
  VerifyDonationUseCase();

  @override
  Future<Either<Failure, Success>> call({String? params}) async {
    return await sl<DonationRepository>().verifyDonation(params!);
  }
}
