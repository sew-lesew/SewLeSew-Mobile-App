import 'package:dio/dio.dart';

import '../../domain/entities/business_campaign_entity.dart';
import '../model/business_campaign_model.dart';

class BusinessCampaignMapper {
  // Convert BusinessCampaignModel to BusinessCampaignEntity
  static BusinessCampaignEntity toEntity(BusinessCampaignModel model) {
    return BusinessCampaignEntity(
      fullName: model.fullName,
      publicEmail: model.publicEmail,
      publicPhoneNumber: model.publicPhoneNumber,
      contactEmail: model.contactEmail,
      contactPhoneNumber: model.contactPhoneNumber,
      region: model.region,
      city: model.city,
      relativeLocation: model.relativeLocation,
      title: model.title,
      goalAmount: model.goalAmount,
      raisedAmount: model.raisedAmount,
      description: model.description,
      deadline: model.deadline,
      website: model.website,
      bankName: model.bankName,
      holderName: model.holderName,
      accountNumber: model.accountNumber,
      sector: model.sector,
      tinNumber: model.tinNumber,
      licenseNumber: model.licenseNumber,
      category: model.category,
      tinCertificate: model.tinCertificate,
      registrationLicense: model.registrationLicense,
      supportingDocuments: model.supportingDocuments,
      logo: model.logo,
      coverImage: model.coverImage,
      otherImages: model.otherImages,
    );
  }

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
      bankName: entity.bankName,
      holderName: entity.holderName,
      accountNumber: entity.accountNumber,
      sector: entity.sector,
      tinNumber: entity.tinNumber,
      licenseNumber: entity.licenseNumber,
      category: entity.category,
      tinCertificate: entity.tinCertificate,
      registrationLicense: entity.registrationLicense,
      supportingDocuments: entity.supportingDocuments,
      logo: entity.logo,
      coverImage: entity.coverImage,
      otherImages: entity.otherImages,
    );
  }

  static Future<FormData> toFormData(BusinessCampaignModel model) async {
    return FormData.fromMap({
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
      'deadline': model.deadline,
      'website': model.website,
      'bankName': model.bankName,
      'holderName': model.holderName,
      'accountNumber': model.accountNumber,
      'sector': model.sector,
      'tinNumber': model.tinNumber,
      'licenseNumber': model.licenseNumber,
      'category': model.category,

      // Single file uploads
      if (model.tinCertificate != null)
        'tinCertificate':
            await MultipartFile.fromFile(model.tinCertificate!.path),
      if (model.registrationLicense != null)
        'registrationLicense':
            await MultipartFile.fromFile(model.registrationLicense!.path),
      if (model.logo != null)
        'logo': await MultipartFile.fromFile(model.logo!.path),
      if (model.coverImage != null)
        'coverImage': await MultipartFile.fromFile(model.coverImage!.path),

      // List of files for supportingDocuments
      if (model.supportingDocuments != null)
        'supportingDocuments': await Future.wait(model.supportingDocuments!.map(
          (file) async => await MultipartFile.fromFile(file.path),
        )),

      // List of files for otherImages
      if (model.otherImages != null)
        'otherImages': await Future.wait(model.otherImages!.map(
          (file) async => await MultipartFile.fromFile(file.path),
        )),
    });
  }
}
