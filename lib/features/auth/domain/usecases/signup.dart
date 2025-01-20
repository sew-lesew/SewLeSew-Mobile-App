import 'package:unity_fund/features/auth/domain/entities/sign_up_entity.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class SignupUsecase extends Usecase<void, SignUpEntity> {
  @override
  Future<void> call({SignUpEntity? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
