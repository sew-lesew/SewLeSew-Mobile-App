import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class ResendCodeParams {
  final String? email;
  final String? phoneNumber;
  ResendCodeParams({required this.email, required this.phoneNumber});
}

class ResendCodeUsecase extends Usecase<void, ResendCodeParams> {
  @override
  Future<void> call({ResendCodeParams? params}) async {
    return await sl<AuthRepository>().resendCode(params!);
  }
}
