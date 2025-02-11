import 'package:dio/dio.dart';

import '../../domain/entities/business_campaign_entity.dart';
import '../model/business_campaign_model.dart';

class BusinessCampaignMapper {
  // Convert BusinessCampaignEntity to BusinessCampaignModel
  static BusinessCampaignModel fromEntity(BusinessCampaignEntity entity) {
    return BusinessCampaignModel(
      fullName: entity.fullName,
      publicEmail: entity.publicEmail,
      publicPhoneNumber: entity.publicPhoneNumber,
      contactEmail: entity.contactEmail,
      contactPhoneNumber: entity.contactPhoneNumber,
      region: entity.region,
      city: entity.city,
      relativeLocation: entity.relativeLocation,
      title: entity.title,
      goalAmount: entity.goalAmount,
      description: entity.description,
      deadline: entity.deadline,
      website: entity.website,
      bankName: entity.bankName?.name,
      holderName: entity.holderName,
      accountNumber: entity.accountNumber,
      sector: entity.sector?.name,
      tinNumber: entity.tinNumber,
      licenseNumber: entity.licenseNumber,
      category: entity.category?.name,
    );
  }

  static Future<FormData> toFormData(
      BusinessCampaignModel model, BusinessCampaignEntity entity) async {
    return FormData.fromMap({
// all below till reach the sector are also common for all type
      'fullName': model.fullName,
      'publicEmail': model.publicEmail,
      'publicPhoneNumber': model.publicPhoneNumber,
      'contactEmail': model.contactEmail,
      'contactPhoneNumber': model.contactPhoneNumber,
      'region': model.region,
      'city': model.city,
      'relativeLocation': model.relativeLocation,
      'title': model.title,
      'goalAmount': model.goalAmount.toString(),
      'description': model.description,
      'deadline':
          DateTime.parse(model.deadline).toIso8601String().split('T').first,
      'bankName': model.bankName,
      'holderName': model.holderName,
      'accountNumber': model.accountNumber,
      'category': model.category,
      // Single file uploads
      if (entity.tinCertificate != null)
        'tinCertificate':
            await MultipartFile.fromFile(entity.tinCertificate!.path),
      if (entity.registrationLicense != null)
        'registrationLicense':
            await MultipartFile.fromFile(entity.registrationLicense!.path),
      if (entity.coverImage != null)
        'coverImage': await MultipartFile.fromFile(entity.coverImage!.path),
      if (entity.personalDocuments != null)
        'personalDocuments':
            await MultipartFile.fromFile(entity.personalDocuments!.path),
      // List of files for supportingDocuments
      if (entity.supportingDocuments != null)
        'supportingDocuments':
            await Future.wait(entity.supportingDocuments!.map(
          (file) async => await MultipartFile.fromFile(file.path),
        )),

      // List of files for otherImages
      if (entity.otherImages != null)
        'otherImages': await Future.wait(entity.otherImages!.map(
          (file) async => await MultipartFile.fromFile(file.path),
        )),

// The above all are common to the three types of campaigns
// Here it starts to differentiate between the three types of campaigns
// the below three are only for business campaign
// That means they will be send to the api as null for the other two types of campaigns
      'sector': model.sector,
      'tinNumber': model.tinNumber,
      'licenseNumber': model.licenseNumber,

      // logo for only both organizatonal and business
      // That means they will be send to the api as null for the  personal campaigns
      if (entity.logo != null)
        'logo': await MultipartFile.fromFile(entity.logo!.path),

// The below are only for personal campaign
// That means they will be send to the api as null for the other two types of campaigns
    });
  }
}
