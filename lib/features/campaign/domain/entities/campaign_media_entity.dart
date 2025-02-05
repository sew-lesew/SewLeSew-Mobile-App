import 'package:equatable/equatable.dart';

class CampaignMediaEntity extends Equatable {
  final String id;
  final String? campaignId;
  final String url;
  final String? imageType;
  final DateTime? createdAt;

  const CampaignMediaEntity({
    required this.id,
    this.campaignId,
    required this.url,
    this.imageType,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, campaignId, url, imageType, createdAt];
}
