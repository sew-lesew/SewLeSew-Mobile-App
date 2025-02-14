import 'package:dio/dio.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/resources/error_handler.dart';
import '../../../../core/services/token_services.dart';
import '../../../../injection_container.dart';
import '../../../auth/data/services/local/storage_services.dart';

class UserServices {
  final storageService = sl<StorageService>();
  final tokenService = sl<TokenService>();
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstant.BASE_URL));

  UserServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request Starting");
          const pathsWithHeaders = ['/user/me', '/user/update', '/user'];

          if (pathsWithHeaders.contains(options.path)) {
            print("Path with Header for access Token");
            final accessToken = storageService.getAccessToken();
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
              print("Access Token with The same path headers");
              print(accessToken);
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          print("Error occurred: ${error.message}");
          if (error.response?.statusCode == 401 &&
              error.requestOptions.path != "/auth/refresh") {
            print("Attempting to refresh token...");
            try {
              final newAccessToken = await tokenService.refreshToken();
              print("New access token: $newAccessToken");
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              final response = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (e) {
              print("Token refresh failed: $e");
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> updateProfile(Future<FormData> entity) async {
    try {
      // Include the access token in the request headers
      final response = await _dio.patch(
        "/user",
        data: entity,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print("Update successful ${response.data}");
      return response;
    } catch (e) {
      print("Error creating donation: $e");
      throw ErrorHandler.mapErrorToMessage(e);
    }
  }

  Future<Response> getMyProfile() async {
    try {
      return await _dio.get('/user/me');
    } catch (e) {
      throw ErrorHandler.mapErrorToMessage(e);
    }
  }

  Future<Response> deactivateAccount() async {
    print("Starting getting my campaigns");
    try {
      return await _dio.delete('/user');
    } catch (e) {
      throw ErrorHandler.mapErrorToMessage(e);
    }
  }
}
