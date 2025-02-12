// error_handler.dart (Create a new file for error handling)
import 'package:dio/dio.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'dart:async'; // For TimeoutException

class ErrorHandler {
  static String mapErrorToMessage(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is PlatformException) {
      return throw error.message ?? "An error occurred.";
    } else if (error is FormatException) {
      return throw error.message; // Or a more generic message
    } else if (error is TimeoutException) {
      return throw "Connection timed out. Please check your internet connection.";
    } else {
      return throw "An unexpected error occurred. Please try again later.";
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return throw "Request cancelled.";
      case DioExceptionType.connectionTimeout:
        return throw "Connection timed out.";
      case DioExceptionType.receiveTimeout:
        return throw "Receive timed out.";
      case DioExceptionType.sendTimeout:
        return throw "Send timed out.";
      case DioExceptionType.badResponse:
        // Handle specific status codes from the server
        switch (error.response?.statusCode) {
          case 400:
            return throw "Bad Request. Please check your input.";
          case 401:
            return throw "Unauthorized. Please login.";
          case 403:
            return throw "Incorrect credentials. Please try again.";
          case 409:
            return throw "User already exists. Please login";
          case 500:
            return throw "User email already exists. Please change";
          default:
            return throw "An error occurred. Please try again later."; // Generic message
        }
      case DioExceptionType.unknown:
        return throw "Unknown error occurred. Please check your internet connection.";
      default:
        return throw "Please check your internet connection and try again.";
    }
  }
}
