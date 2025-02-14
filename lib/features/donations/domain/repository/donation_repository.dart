import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/features/donations/domain/entities/donation_entity.dart';
import '../../../../core/resources/failure.dart';
import '../../../../core/resources/success.dart';

abstract class DonationRepository {
  Future<DonationEntity> donate({DonationEntity entity});
  Future<Either<Failure, Success>> verifyDonation(String refNum);
  Future<Either<Failure, Success>> getDonationByCampaign(String id);
  Future<List<DonationEntity>> getDonationByUser();
}
