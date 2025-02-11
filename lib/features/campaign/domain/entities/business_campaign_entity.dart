// Entity
import 'dart:io';

import '../../../../core/constants/enum_campaign.dart';

class BusinessCampaignEntity {
  String fullName;
  String? publicEmail;
  String? publicPhoneNumber;
  String contactEmail;
  String contactPhoneNumber;
  String region;
  String city;
  String? relativeLocation;
  String title;
  int goalAmount;
  int? raisedAmount;
  String description;
  String deadline;
  String? website;
  BankName? bankName;
  String holderName;
  String accountNumber;
  BusinessSector? sector;
  String tinNumber;
  String licenseNumber;
  Category? category;
  File? tinCertificate;
  File? registrationLicense;
  List<File>? supportingDocuments;
 File? personalDocuments;
  File? logo;
  File? coverImage;
  List<File>? otherImages;

  BusinessCampaignEntity({
    required this.fullName,
    this.publicEmail,
    this.publicPhoneNumber,
    required this.contactEmail,
    required this.contactPhoneNumber,
    required this.region,
    required this.city,
    this.relativeLocation,
    required this.title,
    required this.goalAmount,
    this.raisedAmount,
    required this.description,
    required this.deadline,
    this.website,
    this.bankName,
    required this.holderName,
    required this.accountNumber,
    this.sector,
    required this.tinNumber,
    required this.licenseNumber,
    this.category,
    this.tinCertificate,
    this.registrationLicense,
    this.supportingDocuments,
    this.personalDocuments,
    this.logo,
    this.coverImage,
    this.otherImages,
  });
  // Factory method to initialize with default values
  factory BusinessCampaignEntity.initialize() {
    return BusinessCampaignEntity(
      fullName: '',
      contactEmail: '',
      contactPhoneNumber: '',
      region: '',
      city: '',
      title: '',
      goalAmount: 0,
      description: '',
      deadline: '',
      holderName: '',
      accountNumber: '',
      tinNumber: '',
      licenseNumber: '',
    );
  }
}
