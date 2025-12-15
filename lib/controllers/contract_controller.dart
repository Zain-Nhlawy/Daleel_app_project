import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/services/contract_service.dart';

class ContractController {
  final ContractService contractService;
  ContractController({required this.contractService});
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
