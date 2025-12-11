import 'package:dio/dio.dart';
import 'api.dart';
import '../storage/secure_storage.dart';

class DioClient extends Api {
  final AppSecureStorage storage;

  DioClient({required this.storage}) : super() {
    dio.interceptors.add(
      InterceptorsWrapper(
  onRequest: (options, handler) async {

  const token = "1|URjPdkzYa71eE7Ams1wfK5deOhIZGBpVZ7JW2Fugad5ec12f";

  options.headers['Authorization'] = 'Bearer $token';

  return handler.next(options);
},

        onError: (error, handler) async {
          print("API Error: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
