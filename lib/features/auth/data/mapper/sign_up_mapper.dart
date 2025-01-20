import '../../domain/entities/sign_up_entity.dart';
import '../model/sign_up_model.dart';

class SignUpMapper {
  static SignUpEntity toEntity(SignUpModel model) {
    return SignUpEntity(
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      password: model.password,
      confirmPassword: model.confirmPassword,
    );
  }

  static SignUpModel fromEntity(SignUpEntity entity) {
    return SignUpModel(
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }
}
