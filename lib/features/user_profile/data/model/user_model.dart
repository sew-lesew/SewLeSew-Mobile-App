import '../../../campaign/data/model/campaign_model.dart';
import '../../../donations/data/model/donation_model.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String? profilePictureUrl;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final List<CampaignModel>? campaigns;
  final List<DonationModel>? donations;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.campaigns,
    this.donations,
    this.profilePicture,
    this.profilePictureUrl,
    this.dateOfBirth,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePictureUrl: json['profilePicture'],
      // parse the json string date to datetime
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      phoneNumber: json['phoneNumber'],

      // make them to
      // campaigns: (json['campaigns'] as List)
      //     .map((e) => CampaignModel.fromJson(e))
      //     .toList(),
      // donations: (json['donations'] as List)
      //     .map((e) => DonationModel.fromJson(e))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
    };
  }
}

// to json and from json

// "id": "2f30baad-89e7-4992-917e-49488f91979e",
//         "email": "kidu@gmail.com",
//         "phoneNumber": null,
//         "createdAt": "2025-01-24T09:14:09.654Z",
//         "updatedAt": "2025-02-10T23:36:23.241Z",
//         "isActive": true,
//         "role": "USER",
//         "isVerified": true,
//         "dateOfBirth": "1925-01-24T00:00:00.000Z",
//         "firstName": "kidu",
//         "lastName": "kidu",
//         "profilePicture": null,
