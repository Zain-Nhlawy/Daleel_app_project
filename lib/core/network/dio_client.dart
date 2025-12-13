import 'package:dio/dio.dart';
import 'api.dart';
import '../storage/secure_storage.dart';
import '../storage/storage_keys.dart';

class DioClient extends Api {
  final AppSecureStorage storage;

  DioClient({required this.storage}) : super() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(StorageKeys.token);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (options.data is FormData) {
            options.headers['Content-Type'] = 'multipart/form-data';
          }

          return handler.next(options);
        },

        onError: (error, handler) async {
          print("API Error: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }
}
