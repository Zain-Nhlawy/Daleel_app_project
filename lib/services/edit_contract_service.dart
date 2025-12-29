import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/edit_contract.dart';

class EditContractService {
  final DioClient apiClient;
  EditContractService({required this.apiClient});

  Future<List<EditContract>?> showEditContractsScreen(int page) async {
    try {
      final response = await dioClient.dio.get(
        "/auth/edited_rent?page=$page",
        queryParameters: {"with": "original_rent,department.user"},
      );

      if (response.statusCode == 200) {
        final List rents = response.data['data'];
        return rents.map((json) => EditContract.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> approveEditContractsScreen(int id) async {
    try {
      final response = await dioClient.dio.post(
        "/auth/edited_rent/$id/approve",
      );

      if (response.statusCode == 200) {
        print("the edit approved");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> rejectEditContractsScreen(int id) async {
    try {
      final response = await dioClient.dio.post("/auth/edited_rent/$id/reject");

      if (response.statusCode == 200) {
        print("the edit rejected");
      }
    } catch (e) {
      print(e);
    }
  }
}
