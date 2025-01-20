import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';
import '../entities/login_entity.dart';

class LoginUsecase extends Usecase<void, LoginEntity> {
  @override
  Future<void> call({LoginEntity? params}) async {
    return await sl<AuthRepository>().login(params!);
  }
}
