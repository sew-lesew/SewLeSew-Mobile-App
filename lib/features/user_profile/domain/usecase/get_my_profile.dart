import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../entities/profile_entity.dart';
import '../repository/user_repository.dart';

class GetMyProfileUsecase extends Usecase<ProfileEntity, void> {
  @override
  Future<ProfileEntity> call({void params}) async {
    return await sl<UserRepository>().getMyProfile();
  }
}
