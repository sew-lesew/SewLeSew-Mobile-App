import 'package:unity_fund/features/auth/domain/entities/sign_up_entity.dart';

import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<void> login(LoginEntity entity);
  Future<void> signup(SignUpEntity signupEnitity);
  Future<void> logout();
  Future<void> deleteMyAccount();
}
