import 'package:sewlesew_fund/features/user_profile/domain/entities/profile_entity.dart';

abstract class UserRepository {
  Future<ProfileEntity> updateProfile(ProfileEntity entity);
  Future<ProfileEntity> getMyProfile();
  Future<void> deactivateMyAccount();
}
