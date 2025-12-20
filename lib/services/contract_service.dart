import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:dio/dio.dart';

class ContractService {
  final DioClient apiClient;
  ContractService({required this.apiClient});

  Future<List<Contracts>?> showContracts() async {
    try {
      final response = await dioClient.dio.get(
        "/auth/rents",
        queryParameters: {
          "with": "user,department,department.user,department.images",
        },
      );

      if (response.statusCode == 200) {
        final List rents = response.data['data'];
        return rents.map((json) => Contracts.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Contracts> createContract({
  required int departmentId,
  required DateTime start,
  required DateTime end,
  required double rentFee,
}) async {
  try {
    final response = await apiClient.dio.post(
      "/auth/rents",
      data: {
        "department_id": departmentId,
        "startRent": start.toIso8601String().split('T').first,
        "endRent": end.toIso8601String().split('T').first,
        "rentFee": rentFee,
      },
    );
    final data = response.data;
    if (data == null) {
      throw Exception('Invalid response from server');
    }

    final status = data['status'];
    final message = data['message'];

    if (status == 'error') {
      throw Exception(message ?? 'Booking failed');
    }

    final rentData = data['data'];
    if (rentData == null || rentData is! Map<String, dynamic>) {
      throw Exception('Invalid response structure');
    }

    return Contracts.fromJson(rentData);

  } on DioException catch (e) {
    throw e;
  } catch (e) {
    throw Exception(e.toString());
  }
}

}
