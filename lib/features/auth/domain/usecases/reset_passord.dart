import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class ResetPasswordParams {
  final String newPassword;
  final String confirmPassword;
  ResetPasswordParams(
      {required this.newPassword, required this.confirmPassword});
}

class ResetPasswordUsecase extends Usecase<void, ResetPasswordParams> {
  @override
  Future<void> call({ResetPasswordParams? params}) async {
    return await sl<AuthRepository>().resetPassword(params!);
  }
}
