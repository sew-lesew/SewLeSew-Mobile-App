class CampaignMediaModel {
  final String id;
  final String? campaignId;
  final String url;
  final String? imageType;
  final DateTime? createdAt;

  CampaignMediaModel({
    required this.id,
    this.campaignId,
    required this.url,
    this.imageType,
    this.createdAt,
  });
  factory CampaignMediaModel.fromJson(Map<String, dynamic> json) {
    return CampaignMediaModel(
      id: json['id'],
      // campaignId: json['campaignId'] ?? '',
      url: json['url'],
      // imageType: json['imageType'] ?? '',
      // createdAt: DateTime.parse(json['createdAt']) ?? DateTime.now(),
    );
  }
}
