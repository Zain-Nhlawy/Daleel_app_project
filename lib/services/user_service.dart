import 'package:daleel_app_project/core/network/dio_client.dart';
import '../core/storage/secure_storage.dart';
import '../models/user.dart';
import '../core/storage/storage_keys.dart';
import 'package:dio/dio.dart';

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
        final user = User.fromJson(data['user'],token: token,);
        await storage.write(StorageKeys.token, token);
        print('Token received from server: $token');
        return user;
      }
      print('Response data: ${response.data}');
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }


Future<User?> register(FormData formData) async {
  try {
    final response = await apiClient.dio.post(
      'auth/register',
      data: formData,
    );
    print('Response data: ${response.data}');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      final token = data['token'];
      final user = User.fromJson(data['user'], token: token);
      await storage.write(StorageKeys.token, token);
      return user;
    }
    print('Response data: ${response.data}');
  } on DioException catch (e) {
    print('Register DioException: $e');
    if (e.response != null) {
      print('Status code: ${e.response!.statusCode}');
      print('Data: ${e.response!.data}');
    } else {
      print('No response received');
    }
  } catch (e) {
    print('Other error: $e');
  }
  return null;
}



Future<User?> getProfile() async {
  try {
    final response = await apiClient.dio.get('auth/me');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      final token = await storage.read(StorageKeys.token);
      return User.fromJson(data, token: token);
    }
  } catch (e) {
    print('GetProfile error: $e');
  }
  return null;
}




  Future<bool> logout() async {
  try {
    // print('🔹 Logging out...');
    final token = await storage.read(StorageKeys.token);
    if (token == null) {
      // print('⚠️ No token found, cannot logout properly');
      return false;
    }
    else{
      print('🔹 Token found: $token');
    }
    final response = await apiClient.dio.post('auth/logout');
    print('🔹 Logout request sent');
    if (response.statusCode == 200) {
      await storage.delete(StorageKeys.token);
      return true;
    }
  } catch (e) {
    print('Logout error: $e');
  }
  return false;
  }


}
