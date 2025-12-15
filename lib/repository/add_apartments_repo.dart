import 'dart:io';
import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:dio/dio.dart';

class AddApartmentsRepo {
  final DioClient dioClient;

  AddApartmentsRepo({required this.dioClient});

  Future<Apartments2> addApartment({
    required int userId,
    required List<File> images,
    String? description,
    String? headDescription,
    double? area,
    Map<String, dynamic>? location,
    double? rentFee,
    bool? isAvailable,
    String? status,
    int? bedrooms,
    int? bathrooms,
    int? floor,
  }) async {
    try {
FormData formData = FormData.fromMap({
  "user_id": userId,
  "description": description,
  "headDescription": headDescription,
  "rentFee": rentFee,
  "area": area,
  "bedrooms": bedrooms,
  "bathrooms": bathrooms,
  "floor": floor,
  "status": status,
  "isAvailable": isAvailable! ? 1 : 0,

  "location[city]": location!["city"],
  "location[governorate]": location["governorate"],
  "location[district]": location["district"] ?? "",
  "location[street]": location["street"] ?? "",
  
  "images[]": [
    for (var img in images)
      await MultipartFile.fromFile(
        img.path,
        filename: img.path.split("/").last,
      )
  ],
});


      final response = await dioClient.dio.post(
        "/auth/departments",
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      return Apartments2.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
