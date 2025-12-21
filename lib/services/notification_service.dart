import '../core/network/dio_client.dart';

class NotificationService {
  final DioClient apiClient;

  NotificationService({required this.apiClient});
Future<String?> getToken(String token) async {
  try {
    final response = await apiClient.dio.post(
      'auth/save-fcm-token',
      data: {'fcm-token': token},
    );
    if (response.statusCode == 201) {

      return "success"; 
    } else {

      print("Error from server: ${response.data}");
    }
  } catch (e) {
    print("Exception in getToken: $e");
  }
  return null;
}

}
