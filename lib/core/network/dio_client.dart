import 'package:dio/dio.dart';
import 'api.dart';
import '../storage/secure_storage.dart';

class DioClient extends Api {
  final AppSecureStorage storage;

  DioClient({required this.storage}) : super() {
    dio.interceptors.add(
      InterceptorsWrapper(
  onRequest: (options, handler) async {

  const token = "5|vHynopmMsAsN15DyGryC2nQz2OAiGlfPC3sLZD6Geb7fbb52";

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
