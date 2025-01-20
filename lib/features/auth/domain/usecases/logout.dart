import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class LogoutUsecase extends Usecase<void, void> {
  @override
  Future<void> call({void params}) {
    return sl<AuthRepository>().logout();
  }
}
