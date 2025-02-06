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
      id: json['id'] as String, // Ensure this is non-null
      campaignId: json['campaignId'] as String?, // Nullable
      url: json['url'] as String, // Ensure this is non-null
      imageType: json['imageType'] as String?, // Nullable
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null, // Nullable
    );
  }
}
