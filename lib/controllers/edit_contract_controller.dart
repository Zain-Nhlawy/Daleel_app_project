import 'package:daleel_app_project/models/edit_contract.dart';
import 'package:daleel_app_project/services/edit_contract_service.dart';

class EditContractController {
  final EditContractService editContractService;
  EditContractController({required this.editContractService});

  List<EditContract> _editContracts = [];
  List<EditContract>? get editContracts => _editContracts;

  Future<List<EditContract>> loadContractsEdit(int page) async {
    try {
      final List<EditContract> contracts =
          await editContractService.showEditContractsScreen(page) ?? [];

      _editContracts = contracts;
      return _editContracts;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> approvingEdit(int id) async {
    try {
      await editContractService.approveEditContractsScreen(id) ;
    } catch (e) {
      rethrow;
    }
  }

    Future<void> rejectingEdit(int id) async {
    try {
      await editContractService.rejectEditContractsScreen(id) ;
    } catch (e) {
      rethrow;
    }
  }
}
