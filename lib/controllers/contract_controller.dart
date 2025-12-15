import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/services/contract_service.dart';
import '../core/storage/secure_storage.dart';

class ContractController {
  final ContractService contractService;
  final AppSecureStorage storage;
  ContractController({required this.contractService, required this.storage});
  List<Contracts>? _contracts;
  List<Contracts>? get contracts => _contracts;
  Future<List<Contracts>?> loadContracts() async {
    try {
      final contracts = await contractService.showContracts();
      if (contracts == null) return null;
      _contracts = contracts;
      return _contracts;
    } catch (e) {
      rethrow;
    }
  }
}
