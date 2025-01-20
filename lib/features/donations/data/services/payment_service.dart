import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentService {
  final Dio _dio;

  PaymentService(this._dio);

  Future<String> initializeChapaPayment({
    required String amount,
    required String email,
    required String firstName,
    required String lastName,
    required String fundTitle,
  }) async {
    try {
      final chapaApiKey = dotenv.env['CHAPA_API_KEY'];

      if (chapaApiKey == null || chapaApiKey.isEmpty) {
        throw Exception(
            "Chapa API key is missing. Please check your .env file.");
      }

      final response = await _dio.post(
        "https://api.chapa.co/v1/transaction/initialize",
        options: Options(
          headers: {
            "Authorization": "Bearer $chapaApiKey",
            "Content-Type": "application/json",
          },
        ),
        data: {
          "amount": amount,
          "currency": "ETB",
          "email": email,
          "first_name": firstName,
          "last_name": lastName,
          "tx_ref": "txn_${DateTime.now().millisecondsSinceEpoch}",
          "callback_url":
              "https://yourdomain.com/callback", // Replace with your callback URL
          "customization[title]": fundTitle,
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['data']['checkout_url']; // Return the payment URL
      } else {
        throw Exception(
            "Failed to initialize payment: ${response.data['message']}");
      }
    } catch (e) {
      throw Exception("Payment initialization failed: $e");
    }
  }
}
