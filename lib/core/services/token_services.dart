import 'package:dio/dio.dart';

import '../../features/auth/data/services/local/storage_services.dart';
import '../../injection_container.dart';
import '../constants/constant.dart';
import '../resources/failure.dart';

class TokenService {
  final storageService = sl<StorageService>();
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstant.BASE_URL));

  TokenService();

  Future<String> refreshToken() async {
    final refreshToken = await storageService.getRefreshToken();
    if (refreshToken == null) {
      throw Exception("No refresh token available");
    }

    try {
      final response = await _dio.post(
        "/auth/refresh",
        data: {'refresh_token': refreshToken},
      );

      final data = response.data;
      await storageService.storeToken(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
      );

      final newAccessToken = storageService.getAccessToken();
      return newAccessToken!;
    } catch (e) {
      throw UnknownFailure("Failed to refresh token: ${e.toString()}");
    }
  }
}
