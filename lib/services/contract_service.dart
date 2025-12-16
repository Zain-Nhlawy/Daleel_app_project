import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/contracts.dart';
import '../core/storage/secure_storage.dart';

class ContractService {
  final DioClient apiClient;
  ContractService({required this.apiClient});

  Future<List<Contracts>?> showContracts() async {
    try {
      final response = await dioClient.dio.get(
        "/auth/rents",
        queryParameters: {"with": "user,department"},
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
    required double  rentFee,
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
      return Contracts.fromJson(response.data['data']['rent']);
    }
    return null;
  }
}
