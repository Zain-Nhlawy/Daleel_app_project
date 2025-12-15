import '../models/rent.dart';
import '../services/rent_service.dart';

class RentController {
  final RentService rentService;

  RentController({required this.rentService});

  Rent? _rent;
  Rent? get rent => _rent;

  Future<Rent?> createRent({
    required int departmentId,
    required String startRent,
    required String endRent,
  }) async {
    try {
      final data = {
        'department_id': departmentId,
        'startRent': startRent,
        'endRent': endRent,
      };

      final newRent = await rentService.createRent(data);
      if (newRent != null) {
        _rent = newRent;
        return _rent;
      } else {
        print('Failed to create rent');
      }
    } catch (e) {
      print('Error in createRent controller: $e');
    }
    return null;
  }

  void clearRent() {
    _rent = null;
  }
}
