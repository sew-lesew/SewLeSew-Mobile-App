import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repository/user_repository.dart';

class DeactivateAccountUsecase extends Usecase<void, void> {
  @override
  Future<void> call({void params}) async {
    final result = await sl<UserRepository>().deactivateMyAccount();
    return result;
  }
}
