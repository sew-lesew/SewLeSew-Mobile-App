import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repositroy/auth_repository.dart';

class VerifyAccountParams {
  final String? email;
  final String? phoneNumber;
  final int? code;
  VerifyAccountParams(
      {required this.email, required this.phoneNumber, required this.code});
}

class VerifyAccountUsecase extends Usecase<void, VerifyAccountParams> {
  @override
  Future<void> call({VerifyAccountParams? params}) async {
    return await sl<AuthRepository>().verifyAccount(params!);
  }
}
