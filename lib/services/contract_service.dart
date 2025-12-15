import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/contracts.dart';
import '../core/storage/secure_storage.dart';

class ContractService {
  final DioClient apiClient;
  final AppSecureStorage storage;
  ContractService({required this.apiClient, required this.storage});

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
}
