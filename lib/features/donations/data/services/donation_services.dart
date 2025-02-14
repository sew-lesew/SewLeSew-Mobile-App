import 'package:dio/dio.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/services/token_services.dart';
import '../../../../injection_container.dart';
import '../../../auth/data/services/local/storage_services.dart';
import '../../domain/entities/donation_entity.dart';
import '../mapper/donation_mapper.dart';
import '../model/donation_model.dart';

class DonationServices {
  final storageService = sl<StorageService>();
  final tokenService = sl<TokenService>();
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstant.BASE_URL));

  DonationServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request Starting");
          const pathsWithHeaders = [
            '/donation/me',
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

  Future<Response> donate(DonationEntity entity) async {
    try {
      print("Starting donation ....");
      print("the id is ${entity.campaignId}");
      final DonationModel donationModel = DonationMapper.fromEntity(entity);
      print('Donation Model: $donationModel ');
      print("Starting toJson Serialization");
      final donationData = donationModel.toJson();
      print("The data after toJson is $donationData");

      // Get the access token
      final accessToken = storageService.getAccessToken();
      if (accessToken == null) {
        throw Exception("Access token is missing");
      }

      // Include the access token in the request headers
      final response = await _dio.post(
        "/donation/${entity.campaignId}",
        data: donationData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      print("Donation successful ${response.data}");
      return response;
    } catch (e) {
      print("Error creating donation: $e");
      rethrow;
    }
  }

  Future<Response> guestDonate(DonationEntity entity) async {
    try {
      print("Starting donation ....");
      print("the id is ${entity.campaignId}");
      final DonationModel donationModel = DonationMapper.fromEntity(entity);
      print('Donation Model: $donationModel ');
      print("Starting toJson Serialization");
      final donationData = donationModel.toJson();
      print("The data after toJson is $donationData");

      // Get the access token
      final accessToken = storageService.getAccessToken();
      if (accessToken == null) {
        throw Exception("Access token is missing");
      }

      // Include the access token in the request headers
      final response = await _dio.post(
        "/donation/${entity.campaignId}",
        data: donationData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      print("Donation successful ${response.data}");
      return response;
    } catch (e) {
      print("Error creating donation: $e");
      rethrow;
    }
  }

  Future<Response> getDonationByCampaign(String id) async {
    return await _dio.get('/donation/$id');
  }

  // Future<Response> verify(String txRef) async {
  //   print("Starting to verify");
  //   final response =
  //       await _dio.post('/donation/verify', data: {'tx_ref': txRef});
  //   return response.data;
  // }

  Future<Response> getDonationByUser() async {
    print("Starting getting my donations");
    return await _dio.get('/donation/me');
  }
}
