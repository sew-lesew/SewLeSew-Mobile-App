import 'dart:io';

import 'package:sewlesew_fund/features/donations/domain/entities/donation_entity.dart';

import '../../../campaign/domain/entities/campaign_entity.dart';

class ProfileEntity {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final File? profilePicture;
  final String? profilePictueUrl;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final List<DonationEntity>? donations;
  final List<CampaignEntity>? campaigns;

  ProfileEntity({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.campaigns,
    this.donations,
    this.profilePicture,
    this.profilePictueUrl,
    this.dateOfBirth,
    this.phoneNumber,
  });
}
