import 'package:dio/dio.dart';
import 'package:unity_fund/core/constants/constant.dart';
import 'package:unity_fund/features/authentication/domain/entities/sign_up_entity.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/login_entity.dart';
import '../local/storage_services.dart';

abstract class AuthServices {
  Future<void> login(LoginEntity entity);
  Future<void> signup(SignUpEntity signupEnitity);
  Future<void> logout();
  Future<void> deleteAccount();
}

class AuthServicesImpl implements AuthServices {
  final storageService = sl<StorageService>();
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstant.BASE_URL));
  AuthServicesImpl() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = storageService.getToken();
      options.headers['Authorization'];
      return handler.next(options);
    }, onError: (error, handler) {
      return handler.next(error);
    }));
  }

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<void> login(LoginEntity entity) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    final token = storageService.getToken();
    try {
      await _dio.post("/users/logout",
          options: Options(headers: {'Authorization': "Bearer $token"}));
      await storageService.clearTokens();
      print("Successfuly signed out");
    } catch (e) {
      print("Error while signing out: $e");
    }
  }

  @override
  Future<void> signup(SignUpEntity signupEnitity) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
