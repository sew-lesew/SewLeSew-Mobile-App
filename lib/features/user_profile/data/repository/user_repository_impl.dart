import 'package:dio/dio.dart';
import 'package:sewlesew_fund/features/user_profile/domain/entities/profile_entity.dart';
import 'package:sewlesew_fund/features/user_profile/domain/repository/user_repository.dart';

import '../../../../injection_container.dart';
import '../mapper/user_mapper.dart';
import '../model/user_model.dart';
import '../services/user_services.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> deactivateMyAccount() async {
    try {
      await sl<UserServices>().deactivateAccount();
    } catch (e) {
      print("User deactivate failed with error ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<ProfileEntity> getMyProfile() async {
    try {
      print('getMyProfile start');
      final response = await sl<UserServices>().getMyProfile();
      print('getMyProfile response: $response');
      final UserModel userModel = UserModel.fromJson(response.data['data']);
      print('getMyProfile userModel: $userModel');
      final ProfileEntity profileEntity = UserMapper.toEntity(userModel);
      print('getMyProfile ProfileEntity: $ProfileEntity');
      return profileEntity;
    } catch (e) {
      print("User get failed with error ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<ProfileEntity> updateProfile(ProfileEntity entity) async {
    try {
      print("model to entity");
      final UserModel userModel = UserMapper.fromEntity(entity);
      print('model to entity: ${userModel.toJson}');
      final Future<FormData> profileData =
          UserMapper.toFormData(userModel, entity);
      print('model to entity: $profileData');
      final response = await sl<UserServices>().updateProfile(profileData);

      final UserModel userResponseModel =
          UserModel.fromJson(response.data['data']);
      final ProfileEntity profileEntity =
          UserMapper.toEntity(userResponseModel);
      return profileEntity;
    } catch (e) {
      print("User update failed with error ${e.toString()}");
      rethrow;
    }
  }
}
