import 'package:sewlesew_fund/features/campaign/data/model/campaign_media_model.dart';

import '../../domain/entities/campaign_detail_entity.dart';
import 'campaign_model.dart';

class CampaignDetailModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double goalAmount;
  final String category;
  final double raisedAmount;
  final String status;
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? businessId;
  final String? charityId;
  final BusinessModel? business;
  final List<CampaignMediaModel> campaignMedia;

  const CampaignDetailModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.goalAmount,
    required this.category,
    required this.raisedAmount,
    required this.status,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.businessId,
    required this.charityId,
    required this.business,
    required this.campaignMedia,
  });
  factory CampaignDetailModel.fromJson(Map<String, dynamic> json) {
    return CampaignDetailModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      goalAmount: double.parse(json['goalAmount']),
      category: json['category'],
      raisedAmount: double.parse(json['raisedAmount']),
      status: json['status'],
      deadline: DateTime.parse(json['deadline']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      businessId: json['businessId'],
      charityId: json['charityId'],
      business: json['business'] != null
          ? BusinessModel.fromJson(json['business'])
          : null,
      campaignMedia: (json['campaignMedia'] as List)
          .map((e) => CampaignMediaModel.fromJson(e))
          .toList(),
    );
  }
}

class BusinessModel extends BusinessEntity {
  const BusinessModel({
    required super.id,
    required super.fullName,
    required super.website,
    required super.sector,
    required super.publicEmail,
    required super.publicPhoneNumber,
    required super.region,
    required super.city,
    required super.relativeLocation,
    required super.createdAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      fullName: json['fullName'],
      website: json['website'],
      sector: json['sector'],
      publicEmail: json['publicEmail'],
      publicPhoneNumber: json['publicPhoneNumber'],
      region: json['region'],
      city: json['city'],
      relativeLocation: json['relativeLocation'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'website': website,
      'sector': sector,
      'publicEmail': publicEmail,
      'publicPhoneNumber': publicPhoneNumber,
      'region': region,
      'city': city,
      'relativeLocation': relativeLocation,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
