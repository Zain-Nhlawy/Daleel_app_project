import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/services/contract_service.dart';

class ContractController {
  final ContractService contractService;
  ContractController({required this.contractService});
  List<Contracts> _contracts = [];
  List<Contracts>? get contracts => _contracts;

  Future<List<Contracts>> loadContractsHistory(int page) async {
    try {
      final List<Contracts> contracts =
          await contractService.showContractsScreen(page) ?? [];

      _contracts = contracts;
      return _contracts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Contracts>> loadContractsScreen(int page) async {
    try {
      final List<Contracts> contracts =
          await contractService.showContractsHistory(page) ?? [];

      _contracts = contracts;
      return _contracts;
    } catch (e) {
      rethrow;
    }
  }

  Future<Contracts?> bookApartment({
    required int apartmentId,
    required DateTime start,
    required DateTime end,
    required double rentFee,
  }) async {
    return await contractService.createContract(
      departmentId: apartmentId,
      start: start,
      end: end,
      rentFee: rentFee,
    );
  }

  Future<Contracts?> updateRent({
    required int rentId,
    required DateTime start,
    required DateTime end,
  }) async {
    final Contracts? updatedRent = await contractService.updateContract(
      rentId: rentId,
      start: start,
      end: end,
    );

    if (updatedRent == null) {
      return null;
    }

    final index = _contracts.indexWhere((c) => c.id == rentId);
    if (index != -1) {
      _contracts[index] = updatedRent;
    }

    return updatedRent;
  }

  Future<Contracts> approveContract({required int rentId}) async {
    final Contracts approvedRent = await contractService.approveRent(
      rentId: rentId,
    );

    final index = _contracts.indexWhere((c) => c.id == rentId);
    if (index != -1) {
      _contracts[index] = approvedRent;
    }

    return approvedRent;
  }

  Future<Contracts> rejectContract({required int rentId}) async {
    final rejectedContract = await contractService.rejectRent(rentId: rentId);

    return rejectedContract;
  }

  Future<bool> cancelRent({required int rentId}) async {
    final success = await contractService.deleteContract(rentId: rentId);

    if (success) {
      _contracts.removeWhere((c) => c.id == rentId);
    }

    return success;
  }
}
