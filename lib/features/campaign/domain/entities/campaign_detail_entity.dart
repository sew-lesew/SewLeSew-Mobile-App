import 'package:equatable/equatable.dart';

import 'campaign_media_entity.dart';

class CampaignDetailEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String goalAmount;
  final String category;
  final String raisedAmount;
  final String status;
  final DateTime deadline;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? businessId;
  // final String? charityId;
  final BusinessEntity? business;
  final List<CampaignMediaEntity> campaignMedia;

  const CampaignDetailEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.goalAmount,
    required this.category,
    required this.raisedAmount,
    required this.status,
    required this.deadline,
    this.createdAt,
    this.updatedAt,
    this.businessId,
    // required this.charityId,
    required this.business,
    required this.campaignMedia,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        goalAmount,
        category,
        raisedAmount,
        status,
        deadline,
        createdAt,
        updatedAt,
        businessId,
        // charityId,
        business,
        campaignMedia,
      ];
}

class BusinessEntity extends Equatable {
  final String id;
  final String fullName;
  final String website;
  final String sector;
  final String publicEmail;
  final String publicPhoneNumber;
  final String region;
  final String city;
  final String relativeLocation;
  final DateTime createdAt;

  const BusinessEntity({
    required this.id,
    required this.fullName,
    required this.website,
    required this.sector,
    required this.publicEmail,
    required this.publicPhoneNumber,
    required this.region,
    required this.city,
    required this.relativeLocation,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        website,
        sector,
        publicEmail,
        publicPhoneNumber,
        region,
        city,
        relativeLocation,
        createdAt,
      ];
}
