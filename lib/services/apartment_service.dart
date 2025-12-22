import '../core/network/dio_client.dart';
import '../models/apartments.dart';

class ApartmentService {
  final DioClient apiClient;

  ApartmentService({required this.apiClient});

  Future<bool?> isFavourite(int id) async {
    try {
      final response = await apiClient.dio.get("/auth/favorites/$id");

      final responseData = response.data;
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data')) {
        final dataPayload = responseData['data'];
        if (dataPayload is Map<String, dynamic> &&
            dataPayload.containsKey('is_favorite')) {
          return dataPayload['is_favorite'] as bool?;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Apartments2?> getApartment(int id) async {
    try {
      final response = await apiClient.dio.get(
        'auth/departments/$id',
        queryParameters: {
          'with': 'images,user,comments,reviews,rents,comments.user',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Apartments2.fromJson(data);
      } else {}
    } catch (e) {}
    return null;
  }

  Future<List<Apartments2>> getApartments() async {
    try {
      final response = await apiClient.dio.get(
        "/auth/departments?with=images,user",
      );
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Apartments2>> getMyApartment(int id) async {
    try {
      final response = await apiClient.dio.get(
        "/auth/departments?user=$id&with=user,images",
      );
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> toggleFavorite(int apartmentId) async {
    try {
      final response = await apiClient.dio.post(
        'auth/departments/$apartmentId/favorite/toggle',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Apartments2>> getFavouriteApartments() async {
    try {
      final response = await apiClient.dio.get("/auth/favorites/me");
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
