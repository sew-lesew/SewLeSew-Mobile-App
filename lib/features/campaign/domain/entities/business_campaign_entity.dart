// Entity
import 'dart:io';

class BusinessCampaignEntity {
  final String fullName;
  final String? publicEmail;
  final String? publicPhoneNumber;
  final String contactEmail;
  final String contactPhoneNumber;
  final String region;
  final String city;
  final String? relativeLocation;
  final String title;
  final double goalAmount;
  final double? raisedAmount;
  final String description;
  final String deadline;
  final String? website;
  final String bankName;
  final String holderName;
  final String accountNumber;
  final String sector;
  final String tinNumber;
  final String licenseNumber;
  final String category;
  final File? tinCertificate;
  final File? registrationLicense;
  final List<File>? supportingDocuments;
  final File? logo;
  final File? coverImage;
  final List<File>? otherImages;

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
}
