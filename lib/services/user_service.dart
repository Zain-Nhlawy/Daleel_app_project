import 'package:daleel_app_project/core/network/dio_client.dart';
import '../core/storage/secure_storage.dart';
import '../models/user.dart';
import '../core/storage/storage_keys.dart';

class UserService {
  final DioClient apiClient;
  final AppSecureStorage storage;

  UserService({required this.apiClient, required this.storage});

  Future<User?> login(String phone, String password) async {
    try {
      final response = await apiClient.dio.post(
        'auth/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data']; 
        final token = data['token'];    
        final user = User.fromJson(data['user'],token: token, );
        await storage.write(StorageKeys.token, token);
        return user;
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }

/*
  Future<User?> getProfile() async {
    try {
      final response = await apiClient.dio.get('auth/me');
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      print('Profile error: $e');
    }
    return null;
  }
  */
}
