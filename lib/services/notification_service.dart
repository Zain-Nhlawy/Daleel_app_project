import '../core/network/dio_client.dart';

class NotificationService {
  final DioClient apiClient;

  NotificationService({required this.apiClient});

  Future<bool> saveToken(String token) async {
    try {
      final response = await apiClient.dio.post(
        'auth/save-fcm-token',
        data: {'fcm_token': token},
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }


}
