// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

// BusinessCampaignModel in Business layer
class BusinessCampaignModel {
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

  BusinessCampaignModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'publicEmail': publicEmail,
      'publicPhoneNumber': publicPhoneNumber,
      'contactEmail': contactEmail,
      'contactPhoneNumber': contactPhoneNumber,
      'region': region,
      'city': city,
      'relativeLocation': relativeLocation,
      'title': title,
      'goalAmount': goalAmount,
      'description': description,
      'deadline': deadline,
      'website': website,
      'bankName': bankName,
      'holderName': holderName,
      'accountNumber': accountNumber,
      'sector': sector,
      'tinNumber': tinNumber,
      'licenseNumber': licenseNumber,
      'category': category,
      'tinCertificate': tinCertificate,
      'registrationLicense': registrationLicense,
      'supportingDocuments': supportingDocuments,
      'logo': logo,
      'coverImage': coverImage,
      'otherImages': otherImages,
    };
  }

  factory BusinessCampaignModel.fromMap(Map<String, dynamic> map) {
    return BusinessCampaignModel(
      fullName: map['fullName'] as String,
      publicEmail:
          map['publicEmail'] != null ? map['publicEmail'] as String : null,
      publicPhoneNumber: map['publicPhoneNumber'] != null
          ? map['publicPhoneNumber'] as String
          : null,
      contactEmail: map['contactEmail'] as String,
      contactPhoneNumber: map['contactPhoneNumber'] as String,
      region: map['region'] as String,
      city: map['city'] as String,
      relativeLocation: map['relativeLocation'] != null
          ? map['relativeLocation'] as String
          : null,
      title: map['title'] as String,
      goalAmount: map['goalAmount'] as double,
      description: map['description'] as String,
      deadline: map['deadline'] as String,
      website: map['website'] != null ? map['website'] as String : null,
      bankName: map['bankName'] as String,
      holderName: map['holderName'] as String,
      accountNumber: map['accountNumber'] as String,
      sector: map['sector'] as String,
      tinNumber: map['tinNumber'] as String,
      licenseNumber: map['licenseNumber'] as String,
      category: map['category'] as String,
      tinCertificate:
          map['tinCertificate'] != null ? map['tinCertificate'] as File : null,
      registrationLicense: map['registrationLicense'] != null
          ? map['registrationLicense'] as File
          : null,
      supportingDocuments: map['supportingDocuments'] != null
          ? List<File>.from((map['supportingDocuments'] as List<File>))
          : null,
      logo: map['logo'] != null ? map['logo'] as File : null,
      coverImage: map['coverImage'] != null ? map['coverImage'] as File : null,
      otherImages: map['otherImages'] != null
          ? List<File>.from((map['otherImages'] as List<File>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessCampaignModel.fromJson(String source) =>
      BusinessCampaignModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
