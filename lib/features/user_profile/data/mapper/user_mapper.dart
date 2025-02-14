import 'package:dio/dio.dart';

import '../../domain/entities/profile_entity.dart';
import '../model/user_model.dart';

class UserMapper {
  // Making toEntity and fromEnity
  static ProfileEntity toEntity(UserModel model) {
    return ProfileEntity(
      id: model.id,
      email: model.email,
      phoneNumber: model.phoneNumber,
      dateOfBirth: model.dateOfBirth,
      firstName: model.firstName,
      lastName: model.lastName,
    );
  }

  static UserModel fromEntity(ProfileEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      dateOfBirth: entity.dateOfBirth,
      firstName: entity.firstName,
      lastName: entity.lastName,
    );
  }

  // making toFormData for profile update

  static Future<FormData> toFormData(
      UserModel model, ProfileEntity entity) async {
    return FormData.fromMap({
      'email': model.email,
      'firstName': model.firstName,
      'lastName': model.lastName,
      'dateOfBirth': model.dateOfBirth?.toIso8601String(),
      'phoneNumber': model.phoneNumber,
      if (entity.profilePicture != null)
        'profilePicture':
            await MultipartFile.fromFile(entity.profilePicture!.path),
    });
  }
}
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
