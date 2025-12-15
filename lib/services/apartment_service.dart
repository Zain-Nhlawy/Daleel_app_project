import '../core/network/dio_client.dart';
import '../models/apartments.dart';

class ApartmentService {
  final DioClient apiClient;

  ApartmentService({required this.apiClient});

  Future<Apartments2?> getApartment(int id) async {
    try {
      final response = await apiClient.dio.get('auth/departments/$id',
        queryParameters: {
          'with': 'images,user,comments,reviews,rents,comments.user'
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Apartments2.fromJson(data);
      } else {
        print('Failed to fetch apartment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Other error in getApartment: $e');
    }
    return null;
  }

  Future<List<Apartments2>> getApartments() async {
    try {
      final response = await apiClient.dio.get("/auth/departments?with=images");
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
