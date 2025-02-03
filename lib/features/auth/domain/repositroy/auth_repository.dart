import 'package:sewlesew_fund/features/auth/domain/entities/sign_up_entity.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/reset_passord.dart';

import '../entities/login_entity.dart';
import '../usecases/forgot_password.dart';
import '../usecases/resend_code.dart';
import '../usecases/verify_account.dart';

abstract class AuthRepository {
  Future<void> login(LoginEntity entity);
  Future<void> signup(SignUpEntity signupEnitity);
  Future<void> logout();
  Future<void> forgotPassword(ForgotPasswordParams params);
  Future<void> resetPassword(ResetPasswordParams params);
  Future<void> resendCode(ResendCodeParams params);
  Future<void> verifyAccount(VerifyAccountParams params);
  Future<void> refresh();
  Future<void> signinGoogle();
}
