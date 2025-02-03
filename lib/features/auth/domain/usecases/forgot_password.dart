import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class ForgotPasswordParams {
  final String? email;
  final String? phoneNumber;
  ForgotPasswordParams({required this.email, required this.phoneNumber});
}

class ForgotPasswordUsecase extends Usecase<void, ForgotPasswordParams> {
  @override
  Future<void> call({ForgotPasswordParams? params}) async {
    return await sl<AuthRepository>().forgotPassword(params!);
  }
}
