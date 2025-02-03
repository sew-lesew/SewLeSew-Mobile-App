import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class RefreshUsecase extends Usecase<void, void> {
  @override
  Future<void> call({void params}) async {
    return await sl<AuthRepository>().refresh();
  }
}
