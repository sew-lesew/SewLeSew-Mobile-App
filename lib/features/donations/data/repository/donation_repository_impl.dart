import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/error_handler.dart';
import 'package:sewlesew_fund/core/resources/failure.dart';
import 'package:sewlesew_fund/core/resources/success.dart';
import 'package:sewlesew_fund/features/donations/data/model/donation_model.dart';
import 'package:sewlesew_fund/features/donations/domain/repository/donation_repository.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/donation_entity.dart';
import '../mapper/donation_mapper.dart';
import '../services/donation_services.dart';

class DonationRepositoryImpl implements DonationRepository {
  @override
  Future<DonationEntity> donate({DonationEntity? entity}) async {
    try {
      print("Donation entity is $entity");
      final response = await sl<DonationServices>().donate(entity!);
      print("Response is $response");
      final DonationModel donationModel =
          DonationModel.fromChapaJson(response.data['data']);
      print(
          "Donation model is ${donationModel.checkoutUrl} and ${donationModel.txRef}");
      final DonationEntity donationEntity =
          DonationMapper.toChapaEntity(donationModel);
      print(
          "Donation entity is ${donationEntity.checkoutUrl} and ${donationEntity.txRef}");

      return donationEntity; // Success
    } catch (e) {
      print("Donation failed with error $e");
      throw ErrorHandler.mapErrorToMessage(e);
    }
  }

  @override
  Future<Either<Failure, Success>> getDonationByCampaign(String id) async {
    try {
      final response = await sl<DonationServices>().getDonationByCampaign(id);
      final data = response.data['data'];
      // debugging
      print("Donation detail data is $data");
      final DonationModel donationModel = DonationModel.fromJson(data);
      print(" Donation detail model is $donationModel");
      final DonationEntity donationEntity =
          DonationMapper.toEntity(donationModel);
      print("Donation detail entity is $donationEntity");
      if (response.statusCode == 200) {
        return Right(Success(
            message: response.data['message'],
            donationEntity: donationEntity)); // Success
      } else {
        return Left(
            ServerFailure(response.data["message"] ?? "Fetch Campaign Failed"));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<List<DonationEntity>> getDonationByUser() async {
    try {
      final response = await sl<DonationServices>().getDonationByUser();
      final data = response.data['data'];
      print("List of Donation are  $data");
      final List<DonationModel> donationModel =
          (data as List).map((e) => DonationModel.fromJson(e)).toList();
      print("List of Donation Model are  $donationModel");
      final List<DonationEntity> donationEntity =
          donationModel.map((e) => DonationMapper.toEntity(e)).toList();
      print("List of Donation are are ${donationEntity[0]}");
      return donationEntity;
    } catch (e) {
      print('Error getting donation by user: $e');
      throw ErrorHandler.mapErrorToMessage(e);
    }
  }

  @override
  Future<Either<Failure, Success>> verifyDonation(String refNum) {
    // TODO: implement verifyDonation
    throw UnimplementedError();
  }
}
