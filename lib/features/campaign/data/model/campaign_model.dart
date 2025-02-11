import 'campaign_media_model.dart';

class CampaignModel {
  final String id;
  final String title;
  final String description;
  final double goalAmount;
  final double raisedAmount;
  final String category;
  final DateTime deadline;
  final String status;
  final List<CampaignMediaModel> campaignMedia;
  final int donationCount;

  const CampaignModel({
    required this.id,
    required this.title,
    required this.description,
    required this.goalAmount,
    required this.raisedAmount,
    required this.category,
    required this.deadline,
    required this.status,
    required this.campaignMedia,
    required this.donationCount,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      goalAmount: double.parse(json['goalAmount']),
      raisedAmount: double.parse(json['raisedAmount']),
      category: json['category'],
      deadline: DateTime.parse(json['deadline']),
      status: json['status'],
      campaignMedia: (json['campaignMedia'] as List)
          .map((e) => CampaignMediaModel.fromJson(e))
          .toList(),
      // How to handle IN _count object there is donation
      donationCount: json['_count']['donation'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'goalAmount': goalAmount.toString(),
  //     'raisedAmount': raisedAmount.toString(),
  //     'category': category,
  //     'deadline': deadline.toIso8601String(),
  //     'status': status,
  //     'campaignMedia': campaignMedia.map((e) => (e).toJson()).toList(),
  //   };
  // }
}
