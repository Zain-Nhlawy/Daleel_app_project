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
        data: {'phone': phone, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final token = data['token'];
        final user = User.fromJson(data['user'], token: token);
        await storage.write(StorageKeys.token, token);
        return user;
      }
    } catch (e) {}
    return null;
  }

  Future<User?> register(FormData formData) async {
    try {
      final response = await apiClient.dio.post(
        'auth/register',
        data: formData,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final token = data['token'];
        final user = User.fromJson(data['user'], token: token);
        await storage.write(StorageKeys.token, token);
        return user;
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
    } catch (e) {}
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
    } catch (e) {}
    return null;
  }

  Future<bool> logout() async {
    try {
      final token = await storage.read(StorageKeys.token);
      if (token == null) {
        return false;
      } else {}
      final response = await apiClient.dio.post('auth/logout');
      if (response.statusCode == 200) {
        await storage.delete(StorageKeys.token);
        return true;
      }
    } catch (e) {}
    return false;
  }
}
