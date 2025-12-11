import 'package:dio/dio.dart';

class Api {
  late Dio dio;

  Api() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://10.47.171.209:8000/api/v1/",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {"Accept": "application/json"},
      ),
    );
  }

  String handleError(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return "Connection timed out";
      }
      if (error.type == DioExceptionType.receiveTimeout) {
        return "Receive timeout";
      }
      if (error.response != null) {
        return error.response?.data.toString() ?? "Unknown server error";
      }
      return "Network error: ${error.message}";
    }
    return "Unexpected error";
  }
}
