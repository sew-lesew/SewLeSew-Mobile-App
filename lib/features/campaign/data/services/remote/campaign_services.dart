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
            '/campaign/charity/personal',
            '/campaign/charity/organization'
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
      Future<FormData> campaignFormData, String campaignType) async {
    try {
      print("Creating campaign ....");
      final formData = await campaignFormData; // Resolve the Future<FormData>
      print("FormData: $formData"); // Log the FormData

      // Determine the endpoint based on the campaignType
      String endpoint;
      switch (campaignType) {
        case 'Business':
          endpoint = '/campaign/business';
          break;
        case 'Personal':
          endpoint = '/campaign/charity/personal';
          break;
        case 'Organizational':
          endpoint = '/campaign/charity/organization';
          break;
        default:
          throw Exception('Invalid campaign type');
      }

      // Send the request to the determined endpoint
      final response = await _dio.post(
        endpoint,
        data: formData, // Pass the resolved FormData
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data', // Add this header
          },
        ),
      );
      print("Campaign created successfully");
      return response;
    } catch (e) {
      print("Error creating campaign: $e");
      rethrow;
    }
  }

  Future<Response> getCampaignById(String id) async {
    return await _dio.get('/campaign/$id');
  }

  Future<Response> getCampaigns(
      {required String? category, required String? name}) async {
    print("Starting getting all campaigns");

    return await _dio
        .get('/campaign', queryParameters: {'Category': category, 'for': name});
  }

  Future<Response> getMyCampaign() async {
    print("Starting getting my campaigns");
    return await _dio.get('/campaign/me');
  }
}
