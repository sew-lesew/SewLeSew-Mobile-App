// Entity
import 'dart:io';

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
  double goalAmount;
  double? raisedAmount;
  String description;
  String deadline;
  String? website;
  String bankName;
  String holderName;
  String accountNumber;
  String sector;
  String tinNumber;
  String licenseNumber;
  String category;
  File? tinCertificate;
  File? registrationLicense;
  List<File>? supportingDocuments;
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
    required this.bankName,
    required this.holderName,
    required this.accountNumber,
    required this.sector,
    required this.tinNumber,
    required this.licenseNumber,
    required this.category,
    this.tinCertificate,
    this.registrationLicense,
    this.supportingDocuments,
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
      goalAmount: 0.0,
      description: '',
      deadline: '',
      bankName: '',
      holderName: '',
      accountNumber: '',
      sector: '',
      tinNumber: '',
      licenseNumber: '',
      category: '',
    );
  }
}
