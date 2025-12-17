import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/contracts.dart';

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
        final List rents = response.data['data']['rents'];
        return rents.map((json) => Contracts.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Contracts?> createContract({
    required int departmentId,
    required DateTime start,
    required DateTime end,
    required double rentFee,
  }) async {
    final response = await apiClient.dio.post(
      "/auth/rents",
      data: {
        "department_id": departmentId,
        "startRent": start.toIso8601String().split('T').first,
        "endRent": end.toIso8601String().split('T').first,
        "rentFee": rentFee,
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final rentData = response.data?['data']?['rent'];
      if (rentData != null) {
        return Contracts.fromJson(rentData);
      } else {
        print("Warning: rentData is null");
        return null;
      }
    } else {
      print("Booking failed with status: ${response.statusCode}");
      return null;
    }
  }
}
