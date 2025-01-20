import '../../../campaign/data/model/campaign_model.dart';

class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final List<CampaignModel> campaigns;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.campaigns,
    this.profilePicture,
    this.dateOfBirth,
  });
}
