import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/models/apartments2.dart';

class ApartmentRepo {
  final DioClient dioClient;

  ApartmentRepo({required this.dioClient});

  Future<List<Apartments2>> getApartments() async {
    try {
      final response = await dioClient.dio.get(
        "/auth/departments",
      );
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
