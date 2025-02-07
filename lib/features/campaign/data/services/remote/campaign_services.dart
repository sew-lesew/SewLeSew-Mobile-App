import 'package:dio/dio.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/services/token_services.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/data/services/local/storage_services.dart';

class CampaignServices {
  final storageService = sl<StorageService>();
  final tokenService = sl<TokenService>();
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstant.BASE_URL));
  CampaignServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request Starting");
          const pathsWithHeaders = [
            '/campaign/me',
            '/campaign/business',
          ];

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
  Future<Response> createBusinessCampaign(
      Future<FormData> campaignFormData) async {
    final response =
        await _dio.post('/campaign/business', data: campaignFormData);
    return response;
  }

  Future<Response> getCampaignById(String id) async {
    return await _dio.get('/campaign/$id');
  }

  Future<Response> getCampaigns() async {
    print("Starting getting all campaigns");
    return await _dio.get('/campaign');
  }

  Future<Response> getMyCampaign() async {
    print("Starting getting my campaigns");
    return await _dio.get('/campaign/me');
  }
}
