import 'package:sewlesew_fund/features/auth/domain/entities/login_entity.dart';
import 'package:sewlesew_fund/features/auth/domain/entities/sign_up_entity.dart';
import 'package:sewlesew_fund/features/auth/domain/repositroy/auth_repository.dart';
import 'package:sewlesew_fund/injection_container.dart';

import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/resend_code.dart';
import '../../domain/usecases/reset_passord.dart';
import '../../domain/usecases/verify_account.dart';
import '../services/remote/auth_services.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthServices _authServices = sl<AuthServices>();
  @override
  Future<void> login(LoginEntity entity) async {
    await _authServices.login(entity);
  }

  @override
  Future<void> logout() async {
    await _authServices.logout();
  }

  @override
  Future<void> signup(SignUpEntity signupEnitity) async {
    await _authServices.signup(signupEnitity);
  }

  @override
  Future<void> forgotPassword(ForgotPasswordParams params) async {
    await _authServices.forgotPassword(params);
  }

  @override
  Future<void> refresh() async {
    await _authServices.refresh();
  }

  @override
  Future<void> resendCode(ResendCodeParams params) async {
    await _authServices.resendCode(params);
  }

  @override
  Future<void> resetPassword(ResetPasswordParams param) async {
    await _authServices.resetPassword(param);
  }

  @override
  Future<void> verifyAccount(VerifyAccountParams param) async {
    await _authServices.verifyAccount(param);
  }

  @override
  Future<void> signinGoogle() async {
    await _authServices.signinGoogle();
  }
}
