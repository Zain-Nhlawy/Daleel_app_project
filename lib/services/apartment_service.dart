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

  Future<List<Apartments2>> getFavouriteApartments(int page) async {
    try {
      final response = await apiClient.dio.get("/auth/favorites/me?page=$page");
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
Future<List<Apartments2>> getFilteredApartments(int page, {
  String? governorate, 
  int? bedrooms,    
  int? bathrooms,
  double? minArea,   
  double? maxArea,   
  double? minPrice,
  double? maxPrice, 
  String? sort
}) async {
  try {

    final Map<String, dynamic> queryParameters = {};

    if (governorate != null) {
      queryParameters['governorate'] = governorate;
    }
    if (sort != null) {
      queryParameters['sort'] = sort;
    }
    if (bedrooms != null) {
      queryParameters['bedrooms'] = bedrooms;
    }
    if (bathrooms != null) {
      queryParameters['bathrooms'] = bathrooms;
    }
    if (minArea != null) {
      queryParameters['min_area'] = minArea;
    }
    if (maxArea != null) {
      queryParameters['max_area'] = maxArea;
    }
    if (minPrice != null) {
      queryParameters['min_price'] = minPrice;
    }
    if (maxPrice != null) {
      queryParameters['max_price'] = maxPrice;
    }
    queryParameters['page'] = page;
    final response = await apiClient.dio.get(
      "/auth/departments?with=images,user",
      queryParameters: queryParameters, 
    );

    final data = response.data['data'] as List;
    return data.map((json) => Apartments2.fromJson(json)).toList();
  } catch (e) {
    print("Error in service: $e");
    rethrow;
  }
}

  Future<List<Apartments2>> getSearchedApartments(String search) async {
    try {
      final response = await apiClient.dio.get(
        "/auth/departments?search=$search&with=images,user",
      );
      final data = response.data['data'] as List;

      return data.map((json) => Apartments2.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

}