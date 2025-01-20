import '../../../campaign/domain/entities/campaign_entity.dart';

class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final List<CampaignEntity> campaigns;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.campaigns,
    this.profilePicture,
    this.dateOfBirth,
  });
}
