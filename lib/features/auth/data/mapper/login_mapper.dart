import 'package:unity_fund/features/auth/domain/entities/login_entity.dart';

import '../model/login_model.dart';

// Creating to entity and from entity
class LoginMapper {
  // this may be optional
  static LoginEntity toEntity(LoginModel model) {
    return LoginEntity(email: model.email, password: model.password);
  }

  // from Entity
  static LoginModel fromEntity(LoginEntity entity) {
    return LoginModel(email: entity.email, password: entity.password);
  }
}
