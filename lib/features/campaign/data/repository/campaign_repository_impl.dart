import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/core/resources/failure.dart';
import 'package:sewlesew_fund/core/resources/success.dart';
import 'package:sewlesew_fund/features/campaign/data/mapper/business_campaign_mapper.dart';
import 'package:sewlesew_fund/features/campaign/data/model/business_campaign_model.dart';
import 'package:sewlesew_fund/features/campaign/data/model/campaign_detail_model.dart';
import 'package:sewlesew_fund/features/campaign/data/model/campaign_model.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/campaign_detail_entity.dart';
import 'package:sewlesew_fund/features/campaign/domain/repository/campaign_repository.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/campaign_entity.dart';
import '../mapper/campaign_detail_mapper.dart';
import '../mapper/campaign_mapper.dart';
import '../services/remote/campaign_services.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  @override
  Future<Either<Failure, Success>> createBusinessCampaign(
      {BusinessCampaignEntity? entity, required String campaignType}) async {
    try {
      print("Converting entity to model");
      final BusinessCampaignModel businessCampaignModel =
          BusinessCampaignMapper.fromEntity(entity!);
      print("business campaign model is ${businessCampaignModel.toMap()}");
      print("Converting entity to formdata");
      final campaignFormData =
          BusinessCampaignMapper.toFormData(businessCampaignModel, entity);
      // not as an instance to be displayed
      print("campaign form data is $campaignFormData");
      print("campaign form data is $campaignFormData");
      final response = await sl<CampaignServices>()
          .createBusinessCampaign(campaignFormData, campaignType);

      if (response.statusCode == 200) {
        return Right(Success(message: response.data["message"])); // Success
      } else {
        return Left(ServerFailure(
            response.data["message"] ?? "Campaign Creation Failed"));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> getCampaignById(String id) async {
    try {
      final response = await sl<CampaignServices>().getCampaignById(id);
      final data = response.data['data'];
      // debugging
      print("campaign detail data is $data");
      final CampaignDetailModel campaignDetailModel =
          CampaignDetailModel.fromJson(data);
      print(" campaign detail model is $campaignDetailModel");
      final CampaignDetailEntity campaignDetailEntity =
          CampaignDetailMapper.toEntity(campaignDetailModel);
      print("campaign detail entity is $campaignDetailEntity");
      if (response.statusCode == 200) {
        return Right(Success(
            message: response.data['message'],
            campaignDetailEntity: campaignDetailEntity));
      } else {
        return Left(
            ServerFailure(response.data["message"] ?? "Fetch Campaign Failed"));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> getCampaigns(
      {String? category, String? name}) async {
    try {
      final response = await sl<CampaignServices>()
          .getCampaigns(category: category, name: name);
      print(response);
      final data = response.data['data'];
      print("all campaigns: are $data");
      final List<CampaignModel> campaignModels = data
          .map<CampaignModel>((campaign) => CampaignModel.fromJson(campaign))
          .toList();

      print("campaign models are $campaignModels");

      final List<CampaignEntity> campaignEntities = campaignModels
          .map<CampaignEntity>((campaign) => CampaignMapper.toEntity(campaign))
          .toList();
      print("campaign entities are $campaignEntities");
      if (response.statusCode == 200) {
        return Right(Success(
            message: response.data['message'], campaigns: campaignEntities));
      } else {
        return Left(ServerFailure(
            response.data["message"] ?? "Fetch Campaigns Failed"));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> getMyCampaigns(
      {String? campaignStatus}) async {
    try {
      print("Starting getting my campaigns");
      final response = await sl<CampaignServices>().getMyCampaign();
      print("response is $response");
      final data = response.data['data'];
      print("my campaigns are $data");

      // Filter campaigns based on the provided status
      List<dynamic> filteredData = data;
      if (campaignStatus != null) {
        filteredData = data
            .where((campaign) => campaign['status'] == campaignStatus)
            .toList();
      }

      final List<CampaignModel> myCampaignModels = filteredData
          .map<CampaignModel>((campaign) => CampaignModel.fromJson(campaign))
          .toList();

      final List<CampaignEntity> myCampaigns = myCampaignModels
          .map<CampaignEntity>((campaign) => CampaignMapper.toEntity(campaign))
          .toList();

      print("my campaigns : $myCampaigns");

      if (response.statusCode == 200) {
        return Right(
            Success(message: response.data['message'], campaigns: myCampaigns));
      } else {
        return Left(ServerFailure(
            response.data["message"] ?? "Fetch My Campaigns Failed"));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
