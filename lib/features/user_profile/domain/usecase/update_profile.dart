import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../entities/profile_entity.dart';
import '../repository/user_repository.dart';

class UpdateProfileUsecase extends Usecase<ProfileEntity, ProfileEntity> {
  @override
  Future<ProfileEntity> call({ProfileEntity? params}) async {
    final result = await sl<UserRepository>().updateProfile(params!);
    return result;
  }
}
