  import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/apartments2.dart';
import '../core/storage/secure_storage.dart';

class ApartmentService {
  final DioClient apiClient;
  final AppSecureStorage storage;

  ApartmentService({required this.apiClient, required this.storage});

  Future<List<Apartments2>> getApartments() async {
    try {
      final response = await dioClient.dio.get("/auth/departments?with=images");
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
