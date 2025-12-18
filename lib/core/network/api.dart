import 'package:dio/dio.dart';

class Api {
  late Dio dio;

  Api() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.137.97:8000/api/v1/",
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        validateStatus: (status) {
          return status != null && status < 500;
        },
        headers: {
          "Accept": "application/json",
        },
      ),
    );
  }

  String handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timed out. Please check your internet.";

        case DioExceptionType.sendTimeout:
          return "Send timeout. Request took too long to leave the device.";

        case DioExceptionType.receiveTimeout:
          return "Receive timeout. Server took too long to respond.";

        case DioExceptionType.badCertificate:
          return "Bad certificate. Server identity could not be verified.";

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;

          return "Server error ($statusCode): ${data ?? "Unknown error"}";

        case DioExceptionType.cancel:
          return "Request was cancelled.";

        case DioExceptionType.connectionError:
          return "Network connection failed. No internet or server unreachable.";

        case DioExceptionType.unknown:
          return "Unexpected error: ${error.message}";
      }
    }

    return "Unknown error occurred";
  }
}
